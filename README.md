# WalletCoreTutorial

## WalletCore 라이브러리 + SwiftUI 활용 트랜잭션 생성과 서명 과정 실습 튜토리얼 프로젝트

## 학습 내용
1. **HDWallet의 생성 / 복구 흐름 이해**
2. **블록체인 네트워크 별 파생키 구조 이해**
3. **비트코인 트랜잭션 생성 및 서명 실습**
    - UTXO 직접 지정한 트랜잭션
    - P2SH-P2WPKH(Nested SegWit) 구조에서 트랜잭션
4. **이더리움 트랜잭션 생성 및 실습**


## 블로그 정리
- [비트코인 백서 정리](https://soo-hyn.tistory.com/164)
- [WalletCore를 이용한 HDWallet/니모닉/키의 경로 체계 이해](https://soo-hyn.tistory.com/165)
- [비트코인 트랜잭션부터 채굴까지, 블록이 만들어지는 전 과정 정리](https://soo-hyn.tistory.com/166)
- [WalletCore를 이용한 비트코인 트랜잭션 생성부터 서명](https://soo-hyn.tistory.com/167)
- [UTXO Based Model vs Account Based Model](https://soo-hyn.tistory.com/168)
- [이더리움 트랜잭션 ~ 블록 생성 과정과 비트코인과 비교](https://soo-hyn.tistory.com/169)
- [WalletCore를 이용한 이더리움 트랜잭션 생성부터 서명](https://soo-hyn.tistory.com/170)
- [WalletCore로 생성한 비트코인 트랜잭션, 테스트넷에 전송해보기](https://soo-hyn.tistory.com/171)


## 참고 자료
- [Traust Wallet Core - iOS Intergration Guide](https://developer.trustwallet.com/developer/wallet-core/integration-guide/ios-guide)
- [Wallet Core Documatation](https://trustwallet.github.io/docc/documentation/walletcore)
- [Wallet Core Swift Test Code](https://github.com/trustwallet/wallet-core/tree/master/swift/Tests)
- [Bitcoin Testnet Faucet](https://bitcoinfaucet.uo1.net/send.php)
- [Blocksteam](https://blockstream.info/)
- [비트코인 백서(한글판)](https://bitcoin.org/files/bitcoin-paper/bitcoin_ko.pdf)


## 비트코인 테스트넷 전송(브로드캐스팅)
- Blockstream Testnet API 사용
```swift
curl -d "\(Raw Transaction 정보)" \
-H "Content-Type: text/plain" \
https://blockstream.info/testnet/api/tx
```
<img width="702" height="102" alt="Image" src="https://github.com/user-attachments/assets/a4eda1df-ec24-40fe-9ebc-d6b36c677651" />



→ ea99bd9c46e021807b6eee324dbf5d3c7bae74061b77591650ef4a441f13dc88가 반환되었다

### **Blockstream - 트랜잭션 확인**
<img width="1019" height="1038" alt="Image" src="https://github.com/user-attachments/assets/cbb93dba-841e-42c9-add6-caa32bbd32f1" />

### **Bitcoin Testnet Faucet - 트랜잭션 확인**
<img width="1395" height="1233" alt="image" src="https://github.com/user-attachments/assets/36209478-7907-4fc2-b5af-b2ed08ab83ac" />


### 스크린샷
비밀키와 주소 모두 테스트용입니다.
<table>
  <tr>
    <td align="center">지갑 생성 화면</td>
    <td align="center">지갑 정보 확인</td>
    <td align="center">비밀키 확인</td>
    <td align="center">비트코인 트랜잭션</td>
    <td align="center">이더리움 트랜잭션</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/d897a952-4120-4218-bf01-bafb40bc5bd9" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/b1b44522-d652-43e8-b0ca-0e5b63690315" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/dda644b0-31e2-4f81-b7fe-a08705d6b4b2" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/47a5910b-ef7a-4c1e-913c-02032ed662fa" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/c2118e1f-3624-48e4-8d0c-0308975998fa" width="200"></td>
  </tr>
</table>
