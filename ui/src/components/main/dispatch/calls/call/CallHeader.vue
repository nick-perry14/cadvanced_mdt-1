<template>
    <div class="call-header">
        <div class="top-row">
            <div class="key-info">
                <div class="summary">
                    <div class="call-type">{{call.callIncidents.map(inc => inc.name).join(', ')}}</div>
                    <div class="call-location">
                        {{call.callLocations.map(loc => loc.name).join(', ')}}
                    </div>
                    <div v-if="call.assignedUnits.length > 0" class="call-units">
                        <span
                            v-for="unit in units"
                            :key="unit.id"
                            :style="{ color: '#' + unit.unitState.colour }"
                        >
                            {{unit.callSign}}
                        </span>
                    </div>
                </div>
                <div class="is-assigned" v-if="call.assignedUnits.length > 0">
                    <i class="fas fa-users"></i>
                </div>
                <div @click="toggled" class="expand-button">
                    <i v-if="!isOpen" class="fas fa-toggle-off"></i>
                    <i v-else class="fas fa-toggle-on"></i>
                </div>
            </div>
        </div>
        <div class="bottom-row">
            <div class="call-actions">
                <MiniButton
                    @miniClick="openCallModal"
                    class="call-state-button"
                    text="Edit"
                    colour="rgba(0,255,0,0.5)"
                />
                <MiniButton
                    @miniClick="deleteCall"
                    text="Delete"
                    colour="rgba(255, 0, 0, 0.5)"
                />
            </div>
        </div>
    </div>
</template>

<script>
import MiniButton from '../../../../MiniButton.vue';
import clientSender from '../../../../../mixins/clientSender';
export default {
    components: {
        MiniButton
    },
    props: {
        call: {
            type: Object,
            required: true
        },
        isOpen: {
            type: Boolean,
            required: true
        }
    },
    mixins: [clientSender],
    computed: {
        units() {
            const allUnits = this.$store.getters.getUnits;
            const callUnits = this.call.assignedUnits.map(unit => unit.id);
            return allUnits.filter(candidate => callUnits.includes(candidate.id));
        }
    },
    methods: {
        toggled() {
            this.$emit('toggled');
        },
        openCallModal() {
            this.$store.commit('setModal', {
                type: 'call',
                data: {
                    open: true,
                    type: 'call',
                    entity: this.call
                }
            })
        },
        deleteCall() {
            this.sendClientMessage('deleteCall', this.call);
        }
    }
};
</script>

<style scoped>
.call-header {
    display: flex;
    flex-direction: column;
    background: rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 14px;
    min-height: 98px;
}
.top-row {
    margin-bottom: 20px;
    flex: 1;
}
.key-info {
    display: flex;
}
.is-assigned {
    padding: 0 10px;
    color: rgba(255,255,255,0.7);
}
.summary {
    flex: 1;
}
.expand-button {
    font-size: 25px;
    color: rgba(255, 255, 255, 0.5);
    text-align: right;
    color: rgba(0, 0, 0, 0.3);
    padding-left: 10px;
}
.expand-button i {
    display: block;
}
.call-actions {
    display: flex;
    flex-grow: 1;
    justify-content: flex-end;
}
.call-type {
    color: rgba(255,255,255,0.6);
    font-weight: bold;
    text-transform: uppercase;
}
.call-location,
.call-units {
    color: rgba(255,255,255,0.6);
    font-size: 10px;
    margin: 3px 0;
}
.bottom-row {
    font-size: 14px;
    color: rgba(255, 255, 255, 0.5);
}
.call-state-button {
    margin-right: 10px;
}
</style>
