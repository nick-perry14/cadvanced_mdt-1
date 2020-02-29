<template>
    <div>
        <div id="units">
            <Unit
                @leaveUnit="leaveUnit(unit.id)"
                @beingEdited="setEditedUnit(unit.id)"
                @unitToggle="setUnitOpen(unit.id)"
                v-for="unit in units"
                :key="unit.id"
                :unit="unit"
                :isOpen="isUnitOpen(unit.id)"
                :class="{ open: isUnitOpen(unit.id) }"
            ></Unit>
        </div>
        <RanksModal @selectRank="joinUnit" />
        <StatesModal @selectState="selectState" />
    </div>
</template>

<script>
import Unit from './unit/Unit.vue';
import clientSender from '../../../../mixins/clientSender';
import RanksModal from '../../../reusable/Officer/RanksModal.vue';
import StatesModal from '../../../reusable/Unit/StatesModal.vue';
export default {
    data: function() {
        return {
            unitBeingEdited: 0,
            unitsOpen: []
        };
    },
    mixins: [clientSender],
    components: {
        Unit,
        RanksModal,
        StatesModal
    },
    computed: {
        units() {
            return this.$store.getters.getUnits;
        }
    },
    methods: {
        setEditedUnit(unitId) {
            this.unitBeingEdited = unitId;
        },
        leaveUnit(unitId) {
            const user = this.$store.getters.getUser;
            this.sendClientMessage('removeUserFromUnit', {
                userId: user.id,
                unitId: unitId
            });
        },
        joinUnit(rankId) {
            const user = this.$store.getters.getUser;
            this.sendClientMessage('addUserToUnit', {
                userId: user.id,
                unitId: this.unitBeingEdited,
                rankId
            });
            this.unitBeingEdited = 0;
        },
        selectState(stateId) {
            this.sendClientMessage('setUnitState', {
                stateId: stateId,
                unitId: this.unitBeingEdited
            });
            this.unitBeingEdited = 0;
        },
        isUnitOpen(id) {
            return this.unitsOpen.includes(id);
        },
        setUnitOpen(id) {
            if (!this.isUnitOpen(id)) {
                this.unitsOpen.push(id);
            } else {
                this.unitsOpen.splice(
                    this.unitsOpen.findIndex(u => u == id),
                    1
                );
            }
        }
    }
};
</script>

<style scoped>
#units {
    display: grid;
    grid-gap: 10px;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    grid-auto-rows: 145px;
    grid-auto-flow: dense;
}
.open {
    grid-row: span 4;
}
</style>
