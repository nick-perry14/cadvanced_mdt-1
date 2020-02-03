<template>
    <div id="search-bar">
        <input type="text" id="search-first-name" placeholder="First name" />
        <input type="text" id="search-surname" placeholder="Surname" />
        <input
            type="text"
            id="search-date-of-birth"
            placeholder="Date of birth"
        />
        <input type="text" id="search-id" placeholder="Citizen ID" />
    </div>
</template>

<style scoped>
#search-bar {
    display: flex;
    justify-content: space-between;
}
#search-bar > input {
    width: 310px;
    height: 16px;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.5);
    background: none;
    padding: 20px 20px 24px 20px;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 24px;
    letter-spacing: 0.12em;
}
</style>
