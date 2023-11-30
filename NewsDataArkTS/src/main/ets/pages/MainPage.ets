import http from '@ohos.net.http'

@Entry
@Component
struct MainPage {
  @State message: string = 'Main Page';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Blank()
        Button(){
          Text($r('app.string.button_http'))
            .fontSize(16)
            .fontColor('#888888')
            .fontWeight(FontWeight.Bold)
        }
        .width('49%')
        .height('40vp')
        .backgroundColor('#dedbdb')
        .onClick(() => {
          // this.testHttpGet()
          this.testHttpPost()
        })
      }
      .width('100%')
    }
    .height('100%')
  }

  testHttpGet() {
    let httpRequest = http.createHttp();
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header))
    })
    let url = "https://EXAMPLE_URL?param1=v1&param2=v2";
    let promise = httpRequest.request(url, {
      method: http.RequestMethod.GET,
      connectTimeout: 60000,
      readTimeout: 60000,
      header: {
        'Content-Type': 'application/json'
      }
    })
    promise.then((data) => {
      if (data.responseCode === http.ResponseCode.OK) {
        console.info('Result:' + data.result);
        console.info('code:' + data.responseCode);
      }
    }).catch(() => {
      console.info('error:');
    })
  }

  testHttpPost() {
    let httpRequest = http.createHttp();
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header))
    })
    let url = "https://EXAMPLE_URL";
    let promise = httpRequest.request(url, {
      method: http.RequestMethod.POST,
      extraData: {
        "param1": "value1",
        "param2": "value2",
      },
      connectTimeout: 60000,
      readTimeout: 60000,
      header: {
        'Content-Type': 'application/json'
      }
    })
    promise.then((data) => {
      if (data.responseCode === http.ResponseCode.OK) {
        console.info('Result:' + data.result)
        console.info('code:' + data.responseCode)
      }
    }).catch(() => {
      console.info('error:' + JSON.stringify("err"))
    })
  }
}