<template>
    <div>
        <CallModal v-if="callModalOpen" />
        <div v-if="isSelfDispatch" id="new-call-header">
            <MiniButton
                @miniClick="openCallModal"
                text="Create new call"
                colour="rgba(0, 255, 0, 0.5)"
            />
        </div>
        <div v-if="calls.length > 0" id="calls">
            <Call
                v-for="call in calls"
                :key="call.id"
                :call="call"
                :isOpen="isCallOpen(call.id)"
                @callToggle="setCallOpen(call.id)"
                :class="{ open: isCallOpen(call.id) }"
            />
        </div>
        <div v-if="!calls || calls.length == 0" id="no-calls">
            <div id="no-calls-text">No calls at present</div>
        </div>
    </div>
</template>

<script>
import Call from './call/Call.vue';
import CallModal from '../../../reusable/Call/CallModal.vue';
import MiniButton from '../../../MiniButton.vue';
export default {
    data: function () {
        return {
            callsOpen: []
        };
    },
    components: {
        Call,
        CallModal,
        MiniButton
    },
    computed: {
        calls() {
            return this.$store.getters.getCalls;
        },
        callModalOpen() {
            return this.$store.getters.getIsModalOpen('call');
        },
        isSelfDispatch() {
            return this.$store.getters.getResourceConfig.self_dispatch;
        }
    },
    methods: {
        isCallOpen(id) {
            return this.callsOpen.includes(id);
        },
        setCallOpen(id) {
            if (!this.isCallOpen(id)) {
                this.callsOpen.push(id);
            } else {
                this.callsOpen.splice(
                    this.callsOpen.findIndex(u => u == id),
                    1
                );
            }
        },
        openCallModal() {
            this.$store.commit('setModal', {
                type: 'call',
                data: {
                    open: true,
                    type: 'call',
                    entity: {
                        assignedUnits: [],
                        callDescriptions: [],
                        callGrade: {},
                        callIncidents: [],
                        callLocations: [],
                        callType: {},
                        callerInfo: '',
                        id: null
                    }
                }
            });
        },
    }
};
</script>

<style scoped>
#new-call-header {
    text-align: right;
    margin-bottom: 20px;
}
#calls {
    display: grid;
    grid-gap: 10px;
    grid-template-columns: repeat(auto-fit, minmax(300px, auto));
    grid-auto-rows: 145px;
    grid-auto-flow: dense;
}
.open {
    grid-row: span 3;
}
#no-calls {
    display: flex;
    width: 100%;
    justify-content: center;
    padding-top: 380px;
    font-size: 30px;
    color: rgba(255, 255, 255, 0.5);
}
</style>
