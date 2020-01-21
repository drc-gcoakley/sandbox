import {ObjectCompare} from './object-compare';

export class ClassFactory {

    constructor(public allowAbsent: boolean = false,
                public allowExtras: boolean = false) {
    }

    /** This is an instance version of the static create(). */
    create<T>(modelType: new () => T, objectData:object, otherObjectData:object = {}): T {
        return ClassFactory.create(modelType, objectData, otherObjectData, this.allowAbsent, this.allowExtras);
    }

    /**
     * Constructs a new instance of the class passed in then validates its properties at runtime.
     *
     * @param modelTypeName     The name of a class which must have a constructor that requires no arguments.
     * @param defaultObjectData An object with property values to be copied to the new instance of 'modelTypeName'.
     * @param otherObjectData   An second, optional object with property values to be copied to the new instance.
     * @param allowAbsent       Should properties defined in the class 'modelTypeName' but not defined in any of passed in
     *                          data objects be acceptable.
     * @param allowExtras       Should properties defined in any of passed in data objects but not defined in the class
     *                          'modelTypeName' be acceptable.
     */
    static create<T>(modelTypeName: (new () => T), defaultObjectData:object, otherObjectData:object = {},
                     allowAbsent: boolean = false, allowExtras: boolean = false): T {

        if (typeof modelTypeName !== 'function') {
            throw new Error("ClassFactory.create() modelTypeName must be the name of a class.")
        }
        if (typeof (modelTypeName.prototype) !== 'object') {
            throw new Error("ClassFactory.create() modelTypeName must be the name of a class.")
        }

        let that = Object.assign(new modelTypeName(), defaultObjectData, otherObjectData);

        if (!ObjectCompare.hasSameProperties(this, that, allowAbsent, allowExtras)) {
            throw new Error("ClassFactory.create() resultant object properties do not match. " +
                "\n\tSet properties: " + JSON.stringify(Object.assign(defaultObjectData, otherObjectData)) +
                "\n\tExpected props: " + JSON.stringify(new modelTypeName())
            );
        }
        return that;
    }

}
