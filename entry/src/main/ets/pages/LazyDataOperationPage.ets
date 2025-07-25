import { RefreshDataSource } from '@abner/lithe_refresh'
import { ActionBar } from '@abner/bar'
import router from '@ohos.router'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:懒加载数据使用，主要封装了增删改查
 * */
@Entry
@ComponentV2
struct LazyDataOperationPage {
  dataSource: RefreshDataSource = new RefreshDataSource() //数据懒加载操作对象，执行数据增删改查
  private mList: string[] =
    ["增加一个", "指定位置增加一个", "指定位置增加多个", "数组添加", "可变参数添加", "删除第一个",
      "删除最后一个",
      "删除指定一个", "删除全部",
      "修改数据"]

  aboutToAppear(): void {
    this.dataSource.initData([0, 1, 2, 3])
  }

  @Builder
  gridViewItemLayout(_this: LazyDataOperationPage, item: Object, index: number): void {
    Button(item.toString())
      .margin({ top: 10 })
      .onClick(() => {
        switch (index) {
          case 0: //增加一个
            _this.dataSource.pushData(100)
            break;
          case 1: //指定位置增加一个
            _this.dataSource.pushDataPosition(2, 200)
            break;
          case 2: //指定位置增加多个
            _this.dataSource.pushDataPositionArray(2, [300, 301])
            break;
          case 3: //数组添加
            _this.dataSource.pushDataArray([300, 301, 302])
            break;
          case 4: //可变参数形式添加
            _this.dataSource.pushDataVariable(400, 401, 402)
            break;
          case 5: //删除第一个
            _this.dataSource.deleteFirst()
            break;
          case 6: //删除最后一个
            _this.dataSource.deleteLast()
            break;
          case 7: //删除指定一个
            _this.dataSource.deleteData(0)
            break;
          case 8: //删除全部
            _this.dataSource.deleteAll()
            break;
          case 9: //修改数据
            _this.dataSource.changeData(3, 9999)
            break;
        }
      })
  }

  build() {
    Column() {

      ActionBar({
        title: "懒加载数据使用",
        leftText: "返回",
        onLeftClick: () => {
          router.back()
        },
      })


      Grid() {
        ForEach(this.mList, (item: string, index: number) => {
          GridItem() {
            this.gridViewItemLayout(this, item, index)
          }
        })
      }.columnsTemplate("1fr 1fr 1fr")
      .height(240)
      .columnsGap(10)
      .rowsGap(10)

      List({ space: 20 }) {
        LazyForEach(this.dataSource, (item: number) => {
          ListItem() {
            Text('' + item)
              .width('100%')
              .height(30)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .backgroundColor(0xFFFFFF)
              .border({ width: 2, color: Color.Pink })
          }
        }, (item: string, index: number) => JSON.stringify(item) + "_" + index)
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .width("100%")
      .layoutWeight(1)
      .padding({ left: 20, right: 20 })
    }
  }
}