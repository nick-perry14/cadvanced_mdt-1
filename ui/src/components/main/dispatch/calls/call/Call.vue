<template>
    <div
        id="call"
    >
        <CallHeader
            @toggled="toggle"
            :call="call"
            :isOpen="isOpen"
        />
        <div
            v-show="isOpen"
            class="details-container"
        >
        Details
        </div>
    </div>
</template>

<script>
import CallHeader from './CallHeader.vue';
export default {
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
    components: {
        CallHeader
    },
    methods: {
        toggle() {
            this.$emit('callToggle');
        }
    }
};
</script>

<style scoped>
#call {
    display: flex;
    flex-direction: column;
    border: 3px solid rgba(255, 255, 255, 0.5);
    box-sizing: border-box;
    border-radius: 10px;
}
#call:first-child {
    margin-left: 0;
}
#call:last-child {
    margin-right: 0;
}
.details-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    overflow-y: auto;
}
</style>