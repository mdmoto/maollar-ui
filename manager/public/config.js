var BASE = {
  /**
   * @description api请求基础路径
   */
  API_DEV: {
    common: "http://localhost:9999",
    buyer: "http://localhost:9999",
    seller: "http://localhost:9999",
    manager: "http://localhost:9999",
  },
  API_PROD: {
    common: "http://18.209.174.139:8890",
    buyer: "http://18.209.174.139:8888",
    seller: "http://18.209.174.139:8889",
    manager: "http://18.209.174.139:8887"
  },
  /**
   * @description // 跳转买家端地址 pc端
   */
  PC_URL: "https://pc-b2b2c.maollar.com",
  /**
   * @description  // 跳转买家端地址 wap端
   */
  WAP_URL: "https://m-b2b2c.maollar.com",
  /**
   *  @description api请求基础路径前缀
   */
  PREFIX: "/manager"
  };
