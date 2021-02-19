<template>
    <div class="call-header">
        <div class="top-row">
            <div class="key-info">
                {{call.id}}
                <div @click="toggled" class="expand-button">
                    <i v-if="!isOpen" class="fas fa-toggle-off"></i>
                    <i v-else class="fas fa-toggle-on"></i>
                </div>
            </div>
        </div>
        <div class="bottom-row">
            <div class="call-actions">
                <MiniButton
                    class="call-state-button"
                    text="Edit"
                    colour="rgba(0,255,0,0.5)"
                />
                <MiniButton
                    text="Delete"
                    colour="rgba(255, 0, 0, 0.5)"
                />
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
        call: {
            type: Object,
            required: true
        },
        isOpen: {
            type: Boolean,
            required: true
        }
    },
    methods: {
        toggled() {
            this.$emit('toggled');
        }
    }
};
</script>

<style scoped>
.call-header {
    background: rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 14px;
    min-height: 98px;
}
.top-row {
    margin-bottom: 20px;
}
.key-info {
    display: flex;
}
.expand-button {
    flex-grow: 1;
    font-size: 25px;
    color: rgba(255, 255, 255, 0.5);
    text-align: right;
    color: rgba(0, 0, 0, 0.3);
}
.expand-button i {
    display: block;
}
.bottom-row {
    display: flex;
    justify-content: space-between;
    align-items: top;
    font-size: 14px;
    color: rgba(255, 255, 255, 0.5);
}
.call-state-button {
    margin-right: 10px;
}
</style>
