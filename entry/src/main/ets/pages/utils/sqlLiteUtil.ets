import relationalStore from '@ohos.data.relationalStore';
import { Context } from '@kit.AbilityKit';
import { ValuesBucket } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';


class DatabaseUtil {
  private rdbStore?: relationalStore.RdbStore
  private tableName: string = 'hist'

  createDB(context: Context) {
    // rdb配置
    const config: relationalStore.StoreConfig = {
      name: 'weather.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    const sql = `create table if not exists hist(
                 location char(500) not null
                  );`
    // 获取rdbStore实例globalThis.
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        //获取rdbStore实例失败的业务逻辑
        console.log('获取rdbStore失败 errCode:' + err.code)
      }
      // 获取rdbStore成功的业务逻辑
      rdbStore.executeSql(sql)
      console.log('testTaf', '成功创建User表！')
      //保存redStore
      this.rdbStore = rdbStore
    })
  }

  async getAllHistory(): Promise<string[]> {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    let result = await this.rdbStore?.query(predicates)
    let history: string[] = []
    if (!result?.isAtLastRow) {
      console.log("查询：数据库为空")

    } else {
      console.log('查询:有结果')
      console.log('查询共有' + result.rowCount.toString() + '\t' + result.columnNames.toString())
    }
    while (result?.goToNextRow()) {

      let his = result?.getString(result.getColumnIndex('location'))

      history.push(his)
      console.log('查询结果' + history.toString())

    }
    return history

  }

  addHistory(location: string) {
    const locate: ValuesBucket = {
      'location': location
    }
    this.rdbStore?.insert(this.tableName, locate
      , (err: BusinessError, rowID: number) => {
        if (err) {
          console.error(`查询Insert , errCode ${err.code}`)
          return
        } else {
          console.info(`查询Insert successful` + location + rowID)

        }
      })
    this.getAllHistory()
  }

  deleteAllHistory() {
    this.rdbStore?.executeSql('DELETE FROM hist')
    console.log('查询 清空数据库！')
  }
}

let HistoryModel = new DatabaseUtil()

export default HistoryModel as DatabaseUtil


