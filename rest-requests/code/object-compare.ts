
export class ObjectCompare {

    static hasSameProperties(first: object,
                             second: object,
                             allowAbsent: boolean = false,
                             allowExtras: boolean = false): boolean {

        let thisProps = this.getProperties(first);
        let thatProps = this.getProperties(second);

        if (allowAbsent == false && allowExtras == false && thisProps.length != thatProps.length) {
            return false;
        }
        if (allowAbsent == false) {
            for (let key of thisProps) {
                if (thatProps.indexOf(key) == -1) {
                    return false;
                }
            }
        }
        if (allowExtras == false) {
            for (let key of thatProps) {
                if (thisProps.indexOf(key) == -1) {
                    return false;
                }
            }
        }
        return true;
    }

    private static getProperties(target): Array<string> {
        return Object.keys(target).filter(k => typeof target[k] !== 'function');
    }

}
