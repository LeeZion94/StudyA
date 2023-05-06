

var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]

var yagomKoreaShop: Shop = Shop(productsList: ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"])
var yagomUSAShop: Shop = Shop(productsList: ["노트북받침대","키보드","마우스","마우스패드","야곰스티커","티셔츠"])
var mango: Camper = Camper()
var redmango: Camper = Camper()

mango.buy(productNumber: 7, at: yagomKoreaShop)
mango.buy(productNumber: 1, at: yagomKoreaShop)
mango.buy(productNumber: 1, at: yagomKoreaShop)
mango.buy(productNumber: 2, at: yagomKoreaShop)
mango.buy(productNumber: 3, at: yagomKoreaShop)

redmango.buy(productNumber: 1, at: yagomUSAShop)
