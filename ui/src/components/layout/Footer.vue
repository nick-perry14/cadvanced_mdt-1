<template>
    <footer>
        <ConnectionStat />
        <Officer id="officer_footer" />
    </footer>
</template>

<script>
import Clock from '../footer/Clock.vue';
import ConnectionStat from '../footer/ConnectionStat.vue';
import Officer from '../footer/Officer.vue';

export default {
    components: {
        Clock,
        ConnectionStat,
        Officer
    },
    computed: {
        styling() {
            return {
                flex: '1 1 0',
                textAlign: 'right'
            };
        }
    }
};
</script>

<style scoped>
footer {
    background: #333;
    grid-area: 3/1/3/1;
    display: flex;
    align-items: center;
    text-transform: uppercase;
    padding: 0 30px;
    font-size: 24px;
    font-weight: 500;
    letter-spacing: 0.1em;
    color: rgba(255, 255, 255, 0.7);
    border-radius: 0 0 5px 5px;
}
#officer_footer {
    flex: 1 1 0;
    text-align: right;
}
</style>
