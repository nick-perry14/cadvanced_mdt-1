<template>
    <div>
        <div id="units">
            <Unit
                @leaveUnit="leaveUnit(unit.id)"
                @beingEdited="setEditedUnit(unit.id)"
                v-for="unit in units"
                :key="unit.id"
                :unit="unit"
            ></Unit>
        </div>
        <RanksModal @selectRank="joinUnit" />
    </div>
</template>

<script>
import Unit from './unit/Unit.vue';
import clientSender from '../../../../mixins/clientSender';
import RanksModal from '../../../reusable/Officer/RanksModal.vue';
import StatusesModal from '../../../reusable/Unit/StatusesModal.vue';
export default {
    data: function() {
        return {
            unitBeingEdited: 0
        };
    },
    mixins: [clientSender],
    components: {
        Unit,
        RanksModal,
        StatusesModal
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
        }
    }
};
</script>

<style scoped>
#units {
    display: flex;
    align-items: stretch;
}
</style>
