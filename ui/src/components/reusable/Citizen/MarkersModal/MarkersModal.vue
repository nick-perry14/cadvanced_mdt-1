<template>
    <Modal :open="isOpen" @close="close">
        <template v-slot:header>
            Choose markers
        </template>
        <template v-slot:body>
            <div class="markers">
                <MarkerDisplay
                    v-for="marker in allMarkers"
                    @addMarker="addMarker(marker.id)"
                    @removeMarker="removeMarker(marker.id)"
                    :isSelected="isSelectedValue(marker.id)"
                    :key="marker.id"
                    :marker="marker"
                />
            </div>
        </template>
    </Modal>
</template>

<script>
    import Modal from '../../Modal.vue';
    import MarkerDisplay from './MarkerDisplay.vue';
    import clientSender from '../../../../mixins/clientSender';
    export default {
        components: {
            Modal,
            MarkerDisplay
        },
        mixins: [clientSender],
        computed: {
            isOpen() {
                return this.$store.getters.getIsModalOpen('markers');
            },
            markerType() {
                return this.$store.getters.getModalData('markers').type;
            },
            selectedValues() {
                return this.$store.getters.getModalData('markers').selected;
            },
            allMarkers() {
                const method = `get${this.markerType}Markers`;
                return this.$store.getters[method];
            }
        },
        methods: {
            isSelectedValue(id) {
                return this.selectedValues.filter(v => v.id === id).length > 0;
            },
            addMarker(id) {
                const modalData = this.$store.getters.getModalData('markers');
                const toSend = {
                    type: this.markerType,
                    typeId: modalData.parentEntityId,
                    markerId: id
                };
                this.sendClientMessage('addMarker', toSend);
                const adding = this.allMarkers.find(m => m.id === id);
                const newMarkers = [...this.selectedValues, adding];
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        selected: newMarkers
                    }
                });
                this.$store.commit('updateSearchResult', {
                    type: this.markerType,
                    typeId: modalData.parentEntityId,
                    data: {
                        markers: newMarkers
                    }
                });
            },
            removeMarker(id) {
                const modalData = this.$store.getters.getModalData('markers');
                const toSend = {
                    type: this.markerType,
                    typeId: modalData.parentEntityId,
                    markerId: id
                };
                this.sendClientMessage('removeMarker', toSend);
                const filtered = this.selectedValues.filter(m => m.id !== id);
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        selected: filtered
                    }
                });
                this.$store.commit('updateSearchResult', {
                    type: this.markerType,
                    typeId: modalData.parentEntityId,
                    data: {
                        markers: filtered
                    }
                });
            },
            close() {
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        open: false
                    }
                });
            }
        }
    };
</script>

<style scoped>
    .markers {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
</style>
