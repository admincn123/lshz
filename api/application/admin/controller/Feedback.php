<?php

namespace app\admin\controller;

use app\admin\model\Feedback as FeedbackModel;

class Feedback extends Common
{
    public function feedbacks()
    {
        $nodes = controller('Common')->nodes();
        $param = _request();
        $offset = ($param['page'] -1) * $param['limit'];
        $query = FeedbackModel::order('time', 'DESC');
        $count = $query->count();
        $feedbacks = $query->limit($offset, $param['limit'])->select();
        _success($feedbacks, $count, $nodes);
    }
}