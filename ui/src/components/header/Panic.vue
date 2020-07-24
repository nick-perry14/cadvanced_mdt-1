<template>
    <div>
        <MiniButton
            @miniClick="startPanic()"
            text="Panic"
            colour="rgba(255,0,0,0.6)"
            borderRadius="3px"
            icon="fa-exclamation-triangle"
            padding="6px 8px"
        />
    </div>
</template>

<script>
import clientSender from '../../mixins/clientSender';
import MiniButton from '../MiniButton.vue';
export default {
    components: { MiniButton },
    methods: {
        startPanic() {
            this.sendClientMessage('startPanic');
        }
    },
    mixins: [clientSender]
};
</script>

<style scoped>
div {
    flex: 2 2 0;
    text-align: right;
}
</style>
