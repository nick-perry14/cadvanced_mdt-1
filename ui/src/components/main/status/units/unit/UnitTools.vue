<template>
    <div id="container">
        <MiniButton
            @miniClick="editUnit"
            text="Edit unit"
            colour="rgba(0, 255, 0, 0.5)"
        />
        <MiniButton
            @miniClick="deleteUnit"
            text="Delete unit"
            colour="rgba(255, 0, 0, 0.5)"
        />
    </div>
</template>

<script>
import MiniButton from '../../../../MiniButton.vue';
import clientSender from '../../../../../mixins/clientSender';
export default {
    props: {
        unit: {
            type: Object,
            required: true
        }
    },
    components: {
        MiniButton
    },
    mixins: [clientSender],
    methods: {
        editUnit() {
            this.$store.commit('setModal', {
                type: 'unit',
                data: {
                    open: true,
                    type: 'unit',
                    entity: this.unit
                }
            });
        },
        deleteUnit() {
            this.sendClientMessage('deleteUnit', this.unit);
        }
    }
};
</script>

<style scoped>
#container {
    display: flex;
    justify-content: space-around;
    margin-bottom: 10px;
}
#container button {
    margin-right: 10px;
}
#container button:last-child {
    margin-right: 0;
}
</style>
