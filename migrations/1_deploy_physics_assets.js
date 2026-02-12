const PurePhysicsAssets = artifacts.require("PurePhysicsAssets");
const PURE_Token = artifacts.require("PURE_Token");

module.exports = async function (deployer) {
  // 1. まずは PURE の核となるトークンをデプロイ
  await deployer.deploy(PURE_Token);
  const pureInstance = await PURE_Token.deployed();
  console.log("PURE Token deployed at:", pureInstance.address);

  // 2. 次に物理アセット（N, W, J, bps, bit, byte）を統括するコントラクトをデプロイ
  await deployer.deploy(PurePhysicsAssets);
  const physicsInstance = await PurePhysicsAssets.deployed();
  console.log("PurePhysicsAssets deployed at:", physicsInstance.address);

  console.log("--------------------------------------------------");
  console.log("物理定数の受肉が完了しました。Port A は起動準備よし。");
  console.log("--------------------------------------------------");
};
