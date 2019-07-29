function jsonAsModelObject(typeClass, json) {
    let jsonObject = typeof json === 'string' ? JSON.parse(json) : json;
    return new typeClass(jsonObject);
}
var Which;
(function (Which) {
    Which[Which["One"] = 0] = "One";
    Which[Which["Two"] = 1] = "Two";
})(Which || (Which = {}));
class Model {
    constructor(model) {
        this.THING = Which.One;
        Object.assign(this, model);
    }
    validate() {
        if (this.num === undefined || this.num <= 0) {
            throw new Error("num is not set. " + JSON.stringify(this));
        }
        if (!this.str) {
            throw new Error("str is not set. " + JSON.stringify(this));
        }
        if (this.THING === undefined || this.THING === null) {
            throw new Error("THING is not set. " + JSON.stringify(this));
        }
    }
}
let x = jsonAsModelObject(Model, '{"THING": {"nothing":null}, "str":"value", "num": 7}');
x.validate();
