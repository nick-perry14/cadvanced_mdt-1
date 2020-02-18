<template>
    <div class="unit-header">
        <div class="top-row">
            <div
                class="callsign"
                :style="{ color: '#' + unit.unitState.colour }"
            >
                {{ unit.callSign }}
            </div>
            <div class="unit-state-name">
                {{ unit.unitState.name }}
            </div>
            <div class="unit-rank-name">{{ rankOnUnit }}</div>
        </div>
        <div class="bottom-row">
            <div class="unit-actions">
                <MiniButton text="Status" colour="rgba(255, 255, 255, 0.3)" />
                <MiniButton
                    v-if="isAssignedToUnit"
                    text="Leave"
                    colour="rgba(255, 0, 0, 0.5)"
                />
                <MiniButton v-else text="Join" colour="rgba(0, 255, 0, 0.5)" />
            </div>
        </div>
    </div>
</template>

<script>
import MiniButton from '../../../../MiniButton.vue';
export default {
    components: {
        MiniButton
    },
    props: {
        unit: {
            type: Object,
            required: true
        }
    },
    computed: {
        isAssignedToUnit() {
            return this.userUnitStatus ? true : false;
        },
        userUnitStatus() {
            const user = this.$store.getters.getUser;
            const userUnits = this.$store.getters.getUserUnits;
            return userUnits.find(
                uu => uu.UserId === user.id && uu.UnitId === this.unit.id
            );
        },
        rankOnUnit() {
            const unitStatus = this.userUnitStatus;
            return unitStatus
                ? this.$store.getters.getRank(unitStatus.UserRankId)
                : null;
        }
    }
};
</script>

<style scoped>
.unit-header {
    background: rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 30px;
}
.top-row {
    margin-bottom: 20px;
}
.callsign {
    font-size: 20px;
    letter-spacing: 0.1em;
}
.bottom-row {
    display: flex;
    justify-content: space-between;
    align-items: top;
    font-size: 14px;
    color: rgba(255, 255, 255, 0.5);
}
.unit-state-name,
.unit-rank-name {
    font-size: 14px;
    color: rgba(255, 255, 255, 0.5);
    text-transform: uppercase;
    letter-spacing: 0.1em;
}
.unit-actions {
    display: flex;
    flex-grow: 1;
    justify-content: flex-end;
}
</style>
