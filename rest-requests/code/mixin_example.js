var AnEnum;
(function (AnEnum) {
    AnEnum[AnEnum["First"] = 0] = "First";
    AnEnum[AnEnum["Second"] = 1] = "Second";
})(AnEnum || (AnEnum = {}));
function activatableMixinFactory(Base) {
    return class extends Base {
        constructor(...args) {
            super(...args);
            this.isActivated = false;
        }
        activate() {
            this.isActivated = true;
        }
        deactivate() {
            this.isActivated = false;
        }
    };
}
class User {
    constructor(name) {
        this.name = name;
    }
}
const ActivatableUser = activatableMixinFactory(User);
// Instantiate the new "ActivatableUser" class
const user = new ActivatableUser("John Doe");
// Initially, the "isActivated" property is false
console.log('is activated: ' + user.isActivated);
// Activate the user
user.activate();
// Now, "isActivated" is true
console.log('is activated: ' + user.isActivated);
