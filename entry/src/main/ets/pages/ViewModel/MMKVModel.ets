import { MMKV } from '@tencent/mmkv'

class MMKVModel {
  setCodes(codeSet: string[]) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeStringSet('codeSet', codeSet)
  }

  getCodes(): string[] {
    let mmkv = MMKV.defaultMMKV()
    let byd = mmkv.decodeStringSet('codeSet') ?? ['']
    return byd
  }
}

const MmkvModel = new MMKVModel()

export default MmkvModel as MMKVModel