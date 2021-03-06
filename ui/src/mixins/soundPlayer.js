import { debounce } from 'vue-debounce';
import { Howl } from 'howler';

export default {
    methods: {
        playSound(sound, repeatWhilePanic) {
            const conf = this.$store.getters.getResourceConfig;
            if (conf && conf.sound_volume) {
                const player = new Howl({
                    src: [sound],
                    loop: repeatWhilePanic,
                    volume: parseFloat(conf.sound_volume),
                    onend: () => {
                        const isPanicActive = this.$store.getters
                            .getPanicActive;
                        if (!isPanicActive) {
                            player.loop(false);
                        }
                    }
                });
                const debounced = debounce(() => player.play(), 1500);
                debounced();
            }
        },
        playPromise(sound) {
            return new Promise(resolve => {
                const conf = this.$store.getters.getResourceConfig;
                if (conf && conf.sound_volume) {
                    const player = new Howl({
                        src: sound,
                        volume: parseFloat(conf.sound_volume),
                        onend: () => resolve()
                    });
                    player.play();
                } else {
                    resolve();
                }
            });
        },
        async playSounds(sounds) {
            return new Promise(async resolve => {
                for (let i = 0; i < sounds.length; i++) {
                    await this.playPromise(sounds[i]);
                }
                resolve();
            });
        },
        playNoDebounce(sounds, interval) {
            for (let i = 0; i < sounds.length; i++) {
                setTimeout(
                    i => {
                        this.playPromise(sounds[i]).then(() =>
                            console.log('played')
                        );
                    },
                    interval * i,
                    i
                );
            }
        },
        playRoger() {
            // Only do this while either the MDT or terminal are open
            if (
                this.$store.getters.isVisible ||
                this.$store.getters.isTerminalVisible
            ) {
                this.playSound('./sounds/roger.ogg');
            }
        },
        playPanic() {
            const conf = this.$store.getters.getResourceConfig;
            if (conf.panic_play_tone) {
                this.playSound('./sounds/panic.ogg', true);
            }
        }
    }
};
