<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-02-15 15:59:20
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-29 16:05:44
 */
return [
    // 支付宝相关配制 start
    'appId'                 => '2018120562476461',                      // 应用ID
    'format'                => 'json',
    'charset'               => 'UTF-8',                                 // 编码格式
    'signType'              => 'RSA2',                                  // 签名方式
    'transport'             => 'http',
    'gatewayUrl'            => 'https://openapi.alipay.com/gateway.do', // 支付宝网关
    // 商户私钥/应用私钥
    'privateKey'            => 'MIIEpAIBAAKCAQEAwt4bLMig4zeVnQg2E0J6VKBQh4ncMMZ+mzSt23yjAm4/ytexeTSXuGr+i6TqtXopeA03ga1fy5ZaKWtEghU7Jk4Woy7VtzoFe9/Nmrf0Y5ovTsZKwbHALUL+B596dGyx9ZcuqIpPATYMYwpIRHLBK/DMjNGi/deJpJ7hXfMg91iNGTAR+QvmtELML6Dgsgc5JTg9p0SfvAyJAo0v/avOOfZI80fxwVUwzOHeiwXx8Auncwe2/tbPdZwDF42XXR23Q5JaniNVQEVGvIURwxBJhJ/TVOrNhItX9h2oNsVhOf/FHMXoH1l8nI1RPk+xdJHgQPy2guDP9uWTNTendkl6eQIDAQABAoIBAGrOtFRijxSbNc0BYCpESKqzyA/SNzcgxOorAJQKB4rghOSYPrUxZ2t0cZp2xRK9J5eenurb7WK4QSjsm3s1Sdtf97ZviEJKchEIhTglVbV2IDHsK7Noyu3EB1qERekkXpI+0Bse29jNGBL84slpoImGDYetq8m4ZsAtOVd2WH5ZPPbRZm8Lh9hJ2zhaMNxFM8zjroSvtv6B4iaoPBqh9bIGutYLA4JJLSBs57VujhQyhvVYTOi+dFaV8SI4xKgscBTGNbRLQ/jRJVpWJz9c2LDv2Ce2jUnW7n/0Rkh8zI7o0s9xzrVSOEw6Rb3YjDU97Bz74avg5LXk5e7bEMqir6UCgYEA4pWEOwQuKDnyXa2OQDiDmpy7huhWnNd3jz4Bpsf4IK3cQAhQg5T1WCos9xs3FgV3ZzGCUvhl1PUeRt0cIAHP++epOTnWIjiCVNnQMzA4rOJa0zzS0X6XoJH3XtqsHothYlQBGfaNJhJCuTrHKC2z8yaygkGYfF4A+0dREmr/DKsCgYEA3Cp/rjeCOR2/OHNA2XT1rrIrCACdhiivoACilBYNMARMZosn0v5LigfFWDGca12Fqyamv82aV3LetC5Xu371Rdgy+XMs4KxJ8EWARRTDIRJiPaMCqUWSKbn6htC/rUk+vWCp9wJMzOmOxpCcyG+ChBVk0V+Ax8zoISu/JTEfjWsCgYEA0CZEhCax9FhPU0l1zX9dPrLO/v7/WjQCbH+s6rb3NaYiGFzLAiXcQTL1fcftkfhRmWX88BWrDrhjKPxEsw6XLzXA2oZMNcGt0R8LSYr59bA3eah9juB5kJOnKOc/iQvH2ZmMLXq2bgwGab0aacmabzvUbx6tY0rEIhKA4qeSR+MCgYEAxa9PN8HVpq1EDk7GMrsnAjYuFyBeUKDlmNgZIrhuHOgvJX/bQUNd1lFF6/uXxHuT0uqAnQXiiJS2zLgzxEGpv43xrzOwXwez2A6/rseGsYJNPaTJde3m4JqCDV0QTmrO78IEuqqRBQjNTxN4AyzE1w5SmQCUpFIjN+2M0rs55oMCgYBZyxfNDvTTikxg1AKS/gWEU4pelsEA8IibxbtQoMPowOcwBhnlehTc74ShcGtznVBFiGaaOwe9pCWno6ECBeguPFC9bMv2Iw3i0lluic2y4XsmmyFyHVUpYanFgYXzI64j+pDV1pyvfbL1XOqihSt1ZSflyVovbo+KC8V6ZJefSA==',
    // 支付宝公钥 网页支付端，查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥
    'publicKeyWeb'          => 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgKYkmizsjNOmRFgLVvqvVdaMGZ2ptvJdgpuqrbEUIaBeCDytuajE4+BBAthIyBFi+zZT++epnxSsPjLxtsPJXIfe5CprQebmljSyD8/8fEVT11+pr1fR3n6DGUTZOegGUnDLj3QWrzaV4DMAgASsLOWy8SkSKs0MM1qIpuLnV9kQZ/srQZxNBLq2xE8p+8IzcJ87iLYXT+5QpAdLnrFy6PDdxMCVeBonQBRHz3v0xZWX9GNVjIv/T5HJ0NNU2zgm5WCwo4fjDKoiYa4YtIASk5WSugqqMIRS4vlfA70uSJfIrxqhyjnDDpJZIlFouhmQTG9yGIhRJfkk75Z33LzaqQIDAQAB',
    // 支付宝公钥 APP支付端
    'publicKeyApp'          => 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB',
    // 应用公钥 APP支付端
    // 'applicationPublicKey'  => 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwt4bLMig4zeVnQg2E0J6VKBQh4ncMMZ+mzSt23yjAm4/ytexeTSXuGr+i6TqtXopeA03ga1fy5ZaKWtEghU7Jk4Woy7VtzoFe9/Nmrf0Y5ovTsZKwbHALUL+B596dGyx9ZcuqIpPATYMYwpIRHLBK/DMjNGi/deJpJ7hXfMg91iNGTAR+QvmtELML6Dgsgc5JTg9p0SfvAyJAo0v/avOOfZI80fxwVUwzOHeiwXx8Auncwe2/tbPdZwDF42XXR23Q5JaniNVQEVGvIURwxBJhJ/TVOrNhItX9h2oNsVhOf/FHMXoH1l8nI1RPk+xdJHgQPy2guDP9uWTNTendkl6eQIDAQAB',

    // 飞鹅云打印机配制 start
    'USER'                  => 'imibox@126.com',                        // *必填*：飞鹅云后台注册账号
    'UKEY'                  => 'nKPC2PWHQgnrk7En',                      // *必填*: 飞鹅云注册账号后生成的UKEY
    'SN'                    => '918534244',                             // *必填*：打印机编号
    // 以下参数不需要修改
    'IP'                    => 'api.feieyun.cn',                        // 接口IP或域名
    'PORT'                  => 80,                                      // 接口IP端口
    'PATH'                  => '/Api/Open/'                             // 接口路径
];