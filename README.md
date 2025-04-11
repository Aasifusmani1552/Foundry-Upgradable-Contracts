# 🧱 UUPS Upgradeable Smart Contracts Demo

This project demonstrates how to build upgradeable smart contracts using the **UUPS (Universal Upgradeable Proxy Standard)** pattern with OpenZeppelin's libraries. It features two contracts: `BoxV1` and `BoxV2`, showcasing how logic can be changed while preserving contract state through proxy-based upgrades.

---

## 🔧 Contracts

### 📦 BoxV1
- A simple contract that stores and updates a single number (`uint256`).
- Acts as the initial implementation contract.

### 📦 BoxV2
- An upgraded version of `BoxV1`.
- Extends functionality or modifies logic (e.g., changes how values are updated or stored).

---

## 🛠️ Upgradeability Pattern

This project uses the **UUPS Upgradeable** pattern provided by [OpenZeppelin](https://docs.openzeppelin.com/contracts/4.x/api/proxy#UUPSUpgradeable).

### Key Tools & Components:

- `UUPSUpgradeable`: Provides internal functions to handle upgrades securely from the logic contract itself.
- `OwnableUpgradeable`: Makes the upgrade function restricted to the contract owner.
- `ERC1967Proxy`: A minimal, transparent proxy implementation storing the implementation address in a fixed storage slot.

---

## 🚀 How It Works

1. `BoxV1` is deployed as the initial implementation contract.
2. `ERC1967Proxy` is deployed, pointing to `BoxV1` as its logic contract.
3. Interactions go through the proxy, which uses `delegatecall` to run `BoxV1`'s logic using the proxy's own storage.
4. When an upgrade is needed, the owner calls the `upgradeTo(address newImplementation)` function (implemented in `BoxV1` or `BoxV2`) to update the proxy’s pointer to `BoxV2`.

---

## ⚠️ Security Note

> ⚠️ **Try to avoid making contracts upgradeable unless absolutely necessary.**

While upgradeable contracts offer powerful flexibility for fixing bugs or adding features, **they introduce significant complexity and risk**. Many high-profile exploits in DeFi and NFT projects have occurred due to misconfigured or vulnerable upgrade logic.

Some developers even consider upgradeability a *"bug rather than a feature"*, due to the attack surface it exposes.

---

## 🧪 Dependencies

- [OpenZeppelin Contracts Upgradeable](https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable)
- Foundry or Hardhat for testing and deployment.

---

## 🧠 Learning References

- [OpenZeppelin UUPS Upgradeable Docs](https://docs.openzeppelin.com/contracts/4.x/upgradeable)
- [Understanding delegatecall and storage layout](https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies#delegatecall-and-storage)

---

## 📁 Folder Structure


---

## ✅ Usage Flow

1. Deploy `BoxV1` implementation.
2. Deploy `ERC1967Proxy` pointing to `BoxV1`.
3. Interact via proxy.
4. Deploy `BoxV2` when ready to upgrade.
5. Call `upgradeTo(BoxV2)` from the proxy (via delegatecall).

---

Feel free to fork and experiment, but always **audit and secure upgrade logic** thoroughly before production use 🔒
