# 语音短信 HTTP . FAQ

* [接口文档](static/语音短信接口文档-v2.0.md)

* 请求示例代码

```python
import requests as req
import hashlib
import time

send_url = 'http://www.umyun.com:18081/openApi/voice/cloudRadio'
acct_id = 'acct20000111'
api_key = '21c092b158321bc4e30d4318f545c'
secret_key = 'e89f45dd1096bfd0e317c874b18bf740d2e010fd11a9698e307a7c264a6'

timestamp = int(time.time_ns() / 1000000)
# 模板id和手机号
send_info = ('160651', '15136858562')
# send_info = ('160651', '15136858562', '变量1;变量2;变量3')


def build_param():
    return {
        'acctId': acct_id,
        'mobile': send_info[1],
        'templateId': send_info[0],
        'timestamp': timestamp,
        # 'templateContent': send_info[2],
        # "rspUrl": "http://localhost:21222/req"
    }


# 云平台 header 格式
def build_headers():
    return {
        'content-type': 'application/json; charset=utf-8',
        'apiKey': api_key,
        'token': build_token()
    }


# 云平台token加密规则
def build_token():
    info = {'acctId': acct_id, 'timestamp': timestamp}
    token = (api_key + str(info) + secret_key).replace(" ", "").replace("'", '"')
    return hashlib.sha256(token.encode()).hexdigest()


if __name__ == '__main__':
    resp = req.post(send_url, json=build_param(send_info[1], send_info[0]), headers=build_headers())
    print(resp.text)

```