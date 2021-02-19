<template>
    <div>
        <div v-if="calls.length > 0" id="calls">
            <Call
                v-for="call in calls"
                :key="call.id"
                :call="call"
                :isOpen="isCallOpen(call.id)"
                @callToggle="setCallOpen(call.id)"
            />
        </div>
        <div v-if="!calls || calls.length == 0" id="no-calls">
            <div id="no-calls-text">No calls at present</div>
        </div>
    </div>
</template>

<script>
import Call from './call/Call.vue';
export default {
    data: function () {
        return {
            callBeingEdited: 0,
            callsOpen: []
        };
    },
    components: {
        Call
    },
    computed: {
        calls() {
            return this.$store.getters.getCalls;
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
    }
};
</script>

<style scoped>
#calls {
    display: grid;
    grid-gap: 10px;
    grid-template-columns: repeat(auto-fit, minmax(300px, auto));
    grid-auto-rows: 145px;
    grid-auto-flow: dense;
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
