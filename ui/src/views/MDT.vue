<template>
    <div id="mdt">
        <Header />
        <Main />
        <Footer />
    </div>
</template>

<script>
import Header from '../components/layout/Header.vue';
import Main from '../views/Main.vue';
import Footer from '../components/layout/Footer.vue';

export default {
    components: {
        Header,
        Main,
        Footer
    }
};
</script>

<style>
body,
input,
textarea,
button {
    font-family: 'Jura', sans-serif;
}
#mdt {
    position: absolute;
    width: 95vw;
    height: 90vh;
    left: 2.5vw;
    top: 5vh;
    background: #4a4a4a;
    border: 5px solid #777;
    border-radius: 10px;
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: 58px auto 48px;
}
</style>