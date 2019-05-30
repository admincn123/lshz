<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-03-11 01:02:27
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-27 15:14:53
 */
namespace app\admin\model;
use think\Db;

class Main
{
    // 统计
    public static function countAllRun()
    {
        $param = _request();
        require 'api/extend/lib/Time.php';
        $Time = new \Time();
        $yesterdayStartEnd = $Time -> yesterdayStartEnd();
        $monthStartEnd = $Time -> monthStartEnd();
        require 'api/extend/lib/Arr.php';
        $Arr = new \Arr();
        $boxs_area = db('boxs_area') -> select();

        // 今日、昨日统计 初始数据集
        $todaySE = [date('Y-m-d 00:00:00'),date('Y-m-d 23:59:59')];
        $yesterdaySE = [date('Y-m-d H:i:s',$yesterdayStartEnd[0]),date('Y-m-d H:i:s',$yesterdayStartEnd[1])];
        $monthSE = [date('Y-m-d H:i:s',$monthStartEnd[0]),date('Y-m-d H:i:s',$monthStartEnd[1])];
        // 月统计 初始数据集
        $month_date=[]; $xs = []; $lr = [];
        // 统计至当日 //统计整月 cal_days_in_month(CAL_GREGORIAN, date('m'), date('Y'))
        for ($i=1; $i<date('d')+1; $i++) {
            if($i < 10) $i='0'.$i;
            // 生成日期 // 生成空销售金额 // 生成空销售利润
            $month_date[]=date('m').'-'.$i; $xs[]=0; $lr[]=0;
        }

        // 默认查询
        if(!array_key_exists('area_id',$param)){
            // 订单查询
            // 今日销售/利润
            $where = [['is_settle','=',17],['time','between',$todaySE]];
            $today_xs = db('user_order') -> where($where) -> sum('goods_total_money');
            $today_lr = db('user_order') -> where($where) -> sum('goods_total_profit');
            // 昨日销售/利润
            $where = [['is_settle','=',17],['time','between',$yesterdaySE]];
            $yesterday_xs = db('user_order') -> where($where) -> sum('goods_total_money');
            $yesterday_lr = db('user_order') -> where($where) -> sum('goods_total_profit');
            // 总销售/利润
            $total_xs = db('user_order') -> where('is_settle',17) -> sum('goods_total_money');
            $total_lr = db('user_order') -> where('is_settle',17) -> sum('goods_total_profit');

            // 月销售额/月利润（拆线图）
            $where = [['is_settle','=','17'],['time','between',$monthSE]];
            $month_order_result = db('user_order') -> where($where) -> select();
            foreach ($month_date as $k => $v) {
                foreach ($month_order_result as $key => $value) {
                    if(strpos($value['time'],$v)){
                        $xs[$k] = $xs[$k] + $value['goods_total_money'];
                        $lr[$k] = $lr[$k] + $value['goods_total_profit'];
                    }
                }
            }
            $month_order = ['date'=>$month_date,'xs'=>$xs,'lr'=>$lr];

            // 盒子剩余商品
            $sysp = Db::query('select sum(a.stock) as stock, sum(b.original_price * a.stock) as jh_price, sum(b.price * a.stock) as price, sum((b.price - b.original_price) * a.stock) as lr_sum from db_boxs_list a left join db_goods b on b.id = a.goods_id where a.status=2 and b.status=2 ORDER BY a.stock DESC');

            // 商品销沉比统计
            $spcxb = Db::query('SELECT a.name AS name, a.price AS price, b.goods_number/a.stock AS cxb FROM db_goods a LEFT JOIN db_user_order_lines b ON b.goods_id = a.id LEFT JOIN db_user_order c ON c.id = b.order_id WHERE c.is_settle = 17 AND c.time BETWEEN "'.$todaySE[0].'" AND "'.$todaySE[1].'" LIMIT 20');

            // 盒子销售金额排行统计
            $xstj = db('user_order')
            -> alias('a')
            -> leftJoin('agent b','a.agent_id = b.id')
            -> leftJoin('boxs c','a.boxs_id = c.id')
            -> where('a.is_settle',17)
            -> field('a.*, b.name as agent_name, b.phone, c.area_id, c.name as boxs_name')
            -> order('a.goods_total_money DESC')
            -> select();
            if(!empty($xstj)){
                foreach ($xstj as $k => $v) {
                    // 分区 查找当前id的所有父级
                    $area_parents = $Arr -> getParents($boxs_area, $v['area_id']);
                    $area_parents_name = '';
                    foreach ($area_parents as $key => $val) {
                        $area_parents_name .= ' - '.$val['name'];
                    }
                    $xstj[$k]['area_parents_name'] = $area_parents_name;
                }
            }
        }else{
            // 查询当前区所有子级区域
            $area_childs = $Arr -> getChildsId($boxs_area, $param['area_id']);
            $area_childs[] = $param['area_id'];
            // 分区下面的所有盒子ID集
            $boxsIds = db('boxs') -> whereIn('area_id',$area_childs) -> field('id') -> select();
            $boxs_ids = [];
            if(!empty($boxsIds)){
                foreach ($boxsIds as $k => $v) {
                    $boxs_ids[] = $v['id'];
                }
            }

            // 订单查询
            // 今日销售/利润
            $today_xs = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> where([['b.time','between',$todaySE]])
            -> sum('b.goods_total_money');
            $today_lr = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> where([['b.time','between',$todaySE]])
            -> sum('b.goods_total_profit');
            // 昨日销售/利润
            $yesterday_xs = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> where([['b.time','between',$yesterdaySE]])
            -> sum('b.goods_total_money');
            $yesterday_lr = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> where([['b.time','between',$yesterdaySE]])
            -> sum('b.goods_total_profit');
            // 总销售/利润
            $total_xs = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> sum('b.goods_total_money');
            $total_lr = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> sum('b.goods_total_profit');

            // 月销售额/月利润（拆线图）
            $month_order_result = db('boxs')
            -> alias('a')
            -> leftJoin('user_order b','a.id = b.boxs_id')
            -> whereIn('area_id',$area_childs)
            -> where([['a.status','=',2],['b.is_settle','=',17]])
            -> where([['b.time','between',$monthSE]])
            -> select();
            foreach ($month_date as $k => $v) {
                foreach ($month_order_result as $key => $value) {
                    if(strpos($value['time'],$v)){
                        $xs[$k] = $xs[$k] + $value['goods_total_money'];
                        $lr[$k] = $lr[$k] + $value['goods_total_profit'];
                    }
                }
            }
            $month_order = ['date'=>$month_date,'xs'=>$xs,'lr'=>$lr];

            // 盒子剩余商品
            $sysp = Db::query('select sum(a.stock) as stock, sum(b.original_price * a.stock) as jh_price, sum(b.price * a.stock) as price, sum((b.price - b.original_price) * a.stock) as lr_sum from db_boxs_list a left join db_goods b on b.id = a.goods_id where a.status=2 and b.status=2 and a.boxs_id in ('.join(',',$boxs_ids).') ORDER BY a.stock DESC');

            // 商品销沉比统计
            $spcxb = Db::query('SELECT a.name AS name, a.price AS price, b.goods_number/a.stock AS cxb FROM db_goods a LEFT JOIN db_user_order_lines b ON b.goods_id = a.id LEFT JOIN db_user_order c ON c.id = b.order_id WHERE c.is_settle = 17 AND c.time BETWEEN "'.$todaySE[0].'" AND "'.$todaySE[1].'" AND c.boxs_id IN ('.join(',',$boxs_ids).') LIMIT 20');

            // 盒子销售金额排行统计
            $xstj = db('user_order')
            -> alias('a')
            -> leftJoin('agent b','a.agent_id = b.id')
            -> leftJoin('boxs c','a.boxs_id = c.id')
            -> where([['a.is_settle','=',17],['a.boxs_id','in',$boxs_ids]])
            -> field('a.*, b.name as agent_name, b.phone, c.area_id, c.name as boxs_name')
            -> order('a.goods_total_money DESC')
            -> select();
            if(!empty($xstj)){
                foreach ($xstj as $k => $v) {
                    // 分区 查找当前id的所有父级
                    $area_parents = $Arr -> getParents($boxs_area, $v['area_id']);
                    $area_parents_name = '';
                    foreach ($area_parents as $key => $val) {
                        $area_parents_name .= ' - '.$val['name'];
                    }
                    $xstj[$k]['area_parents_name'] = $area_parents_name;
                }
            }
        }

        // 返回
        $result = [
            'order'=>[
                'today_xs' => $today_xs, 'today_lr' => $today_lr,
                'yesterday_xs' => $yesterday_xs, 'yesterday_lr' => $yesterday_lr,
                'total_xs' => $total_xs, 'total_lr' => $total_lr
            ],
            'month_order' => $month_order,
            'sysp' => $sysp,
            'xstj' => $xstj,
            'spcxb' => $spcxb
        ];
        _success($result);
    }
    // 修改密码
    public static function editPwdRun($param)
    {
        $db_admin = db('admin');
        if(!$db_admin -> where(['id'=>session('uid'),'password'=>$param['password']]) -> find()){
            _error('原密码错误，再好好想想吧'); 
        }else{
            if($db_admin -> update(['id'=>session('uid'),'password'=>$param['password_new']])){
                session(null);
                _success();
            }else{
                _error();
            }
        }
    }
    // 登录日志
    public static function signLogRun($param)
    {
        $db_admin = db('admin_log');
        $where = ['admin_id'=>session('uid')];
        $result = $db_admin -> where($where) -> limit(($param['page']-1)*$param['limit'],$param['limit']) -> order('id DESC') -> select();
        if(!empty($result)){
            _success($result,$db_admin->where($where)->count());
        }else{
            _nothing();
        }
    }
    // 清除登录日志前100条
    public static function signLogDelRun()
    {
        if(Db::execute('DELETE FROM db_admin_log WHERE 1=1 ORDER BY id LIMIT 100')){
            _success();
        }else{
            _nothing();
        }
    }
}