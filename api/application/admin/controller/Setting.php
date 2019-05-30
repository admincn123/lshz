<?php

namespace app\admin\controller;

use app\admin\model\Params as ParamsModel;

class Setting extends Common
{
    public function save()
    {

        $param = _request('POST');
        $paramsModel = ParamsModel::find();
        if ($paramsModel === null) {
            $paramsModel = new ParamsModel();
        }
        if (isset($param['wx_open_id'])) {
            $paramsModel->wx_open_id = $param['wx_open_id'];
        }
        if (isset($param['wx_app_secret'])) {
            $paramsModel->wx_app_secret = $param['wx_app_secret'];
        }
        if (isset($param['wx_redirect_uri'])) {
            $paramsModel->wx_redirect_uri = $param['wx_redirect_uri'];
        }
        if (isset($param['wx_token'])) {
            $paramsModel->wx_token = $param['wx_token'];
        }
        if (isset($param['wx_mchid'])) {
            $paramsModel->wx_mchid = $param['wx_mchid'];
        }
        if (isset($param['wx_key'])) {
            $paramsModel->wx_key = $param['wx_key'];
        }
        if (isset($param['wx_apiclient_cert'])) {
            $paramsModel->wx_apiclient_cert = $param['wx_apiclient_cert'];
        }
        if (isset($param['wx_apiclient_key'])) {
            $paramsModel->wx_apiclient_key = $param['wx_apiclient_key'];
        }
        if (isset($param['mini_appid'])) {
            $paramsModel->mini_appid = $param['mini_appid'];
        }
        if (isset($param['mini_app_secret'])) {
            $paramsModel->mini_app_secret = $param['mini_app_secret'];
        }
        if (isset($param['logo'])) {
            $paramsModel->logo = $param['logo'];
        }
        if ($paramsModel->save()) {
            _success();
        }
        _error('保存失败');

    }

    public function data()
    {
        $setting = ParamsModel::find();
        _success($setting);
    }
}