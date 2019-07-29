
function jsonAsModelObject<TypeClass>(typeClass, json:string | object) {
    let jsonObject = typeof json === 'string' ? JSON.parse(json) : json;
    return new typeClass(jsonObject) as Exclude<TypeClass, Function>;
}

enum Which { One, Two }

class Model {
    THING: Which = Which.One;
    num: number;
    str: string;

    constructor(model:Model) {
        Object.assign<Model, Model>(this, model);
    }

    validate() {
        if (this.num === undefined || this.num <= 0) {
            throw new Error("num is not set. " + JSON.stringify(this))}
        if (!this.str) {
            throw new Error("str is not set. " + JSON.stringify(this))}
        if (this.THING === undefined || this.THING === null) {
            throw new Error("THING is not set. " + JSON.stringify(this))}
    }
}
let x: Model = jsonAsModelObject<Model>(Model, '{"THING": {"nothing":null}, "str":"value", "num": 7}' );
x.validate();
