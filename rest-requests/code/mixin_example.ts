
export type Proxify<T> = {
    [P in keyof T]: { get(): T[P]; set(v: T[P]): void }
};

/* This appears to be a clear, general replacement for the pattern with 'type Constuctor' below.
    public static merge<Instance, ClassPrototype>(first: Instance, second: ClassPrototype): Instance & ClassPrototype {
        const result: Partial<Instance & ClassPrototype> = {};

        function copy<V>(source) {
            for (const prop in source) {
                if (source.hasOwnProperty(prop)) {
                    (<V>result)[prop] = source[prop];
                }
            }
        }
        copy<Instance>(first);
        copy<ClassPrototype>(second);
        return <Instance & ClassPrototype>result;
    }


This might be a more concise version that allows creation of a more general replacement for the pattern with 'type
 Constuctor' below. I have not yet made an example work though.

export type Newable<TType extends new(...args: any[]) => InstanceType<TType>> = {
    new(...params: any[]): InstanceType<TType>;
};
declare function create<T extends Newable<T>>(kind: T, options?: ConstructorParameters<T>[0]): InstanceType<T>;
*/

type Constructor<T = {}> = new (...args: any[]) => T;

function activatableMixinFactory<Target extends Constructor>(Base: Target) {
    return class extends Base {
        isActivated = false;

        constructor(...args: any[]) {
            super(...args);
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
    name: string;

    constructor(name: string) {
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
