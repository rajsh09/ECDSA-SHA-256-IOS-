# ECDSASHA256IOS

Signature verification using ECDSA (spec256r1)

Get supported public-private key pair..

https://kjur.github.io/jsrsasign/sample/sample-ecdsa.html

Convert in Hexa decimal using 

https://base64.guru/converter/encode/hex

Make sure to add public key header "3059301306072a8648ce3d020106082a8648ce3d030107034200" 52 bit header size for spec256r1

Public key wihtout header: 

0495f9895e66db26cd3e018856a4efc00006defc47ac504599e8b4acad742b6c42034244b0a71baecd2bd7119ece0f89f74faff4ad054d1e72d817f59ee5180ab5

Public key with header: 

0495f9895e66db26cd3e018856a4efc00006defc47ac504599e8b4acad742b6c42034244b0a71baecd2bd7119ece0f89f74faff4ad054d1e72d817f59ee5180ab5
3059301306072a8648ce3d020106082a8648ce3d030107034200

Smaple:

 private let publicKey = "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAElfmJXmbbJs0+AYhWpO/AAAbe/EesUEWZ6LSsrXQrbEIDQkSwpxuuzSvXEZ7OD4n3T6/0rQVNHnLYF/We5RgKtQ=="
 private let plainText = "verify digital signature"
 private let signature = "MEUCIQD3zXEh+lcLUiLuw6w/4TTtf8ipndcQGl1hJSx4Qqh8nwIgAbtKa71ZT1HpZZY1Kamj6mgUW1iOZnOXcT0MEQXjIxY="
