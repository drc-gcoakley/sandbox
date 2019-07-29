import {Constructor} from "../../../../../wksp/eca/typescript/rtm-app/service/lib/eca-rtm-model/src/common/type-utilities";
import {Team} from "../../../../../wksp/eca/typescript/rtm-app/service/lib/eca-rtm-model/src/team-model";

export class TeamLogic {
    constructor(public data:Team) {};

    validate() {
        TeamLogic.validate(this.data);
    }

    static validate(teamData:Team) {
        // TODO: implement API Gateway request validation
        if ((!teamData.name) || (!teamData.projectId) || (!teamData.scoringCenter) || (!teamData.scoringDirector) ||
            (!teamData.shifts) || (!teamData.assignedQuestions)) {

            throw new Error(`Invalid team. Missing some required field(s): name, projectId, scoringCenter, scorignDirectory, shifts[], assignedQuestions[]. Team: ` + JSON.stringify(teamData));
        }
    }
}

function teamLogicMixinFactory <Target extends Constructor>(Base: Target) {
    return class extends Base {
        readonly requirements = ['name', 'projectId', 'scoringCenter', 'scoringDirector', 'shifts', 'assignedQuestions'];

        constructor(...args: any[]) {
            super(...args);
            this.validateValues()
        };

        validateKeys() {
            for (let k in this.requirements) {
                if (! this.hasOwnProperty(k)) {
                    throw new Error("Invalid mixin target class " + String(Base) + "; it lacks the expected property ${k}. " +
                        "Actual properties" + Object.getOwnPropertyNames(this))
                }
            }
        }
        validateValues() {
            // TODO: implement API Gateway request validation
            for (let k in this.requirements) {
                if (this[k] === undefined || this[k] === null) {
                    throw new Error(`Invalid team. It is missing some required field(s): ${this.requirements}. Team: ` + JSON.stringify(this));
                }
            }
        }
    }
}

export const TeamDuckType = teamLogicMixinFactory(Team);
