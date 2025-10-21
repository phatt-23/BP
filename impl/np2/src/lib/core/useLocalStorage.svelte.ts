import { onMount } from 'svelte';
import Serializer from './Serializer';
import { get, writable } from 'svelte/store';

function useLocalStorage<T>(
    key: string, 
    initialValue: T,
    opt: {
        serialize: (obj: any) => string,
        revive: (obj: any) => T,
    } = {
        serialize: (obj: any) => Serializer.serialize(obj),
        revive: (obj: any) => Serializer.revive(obj),
    }
) {
    let value = writable(initialValue);

    onMount(() => {
        const currentValue = localStorage.getItem(key);
        console.debug('checking LOCAL STORAGE:', key, currentValue);
        if (currentValue) {
            const revived = opt.revive(JSON.parse(currentValue))
            value.set(revived);
            console.debug('revived:', revived)
        }
    });

    const save = () => {
        if (get(value)) {
            const serialized = JSON.stringify(opt.serialize(get(value)));
            localStorage.setItem(key, serialized);
        } else {
            localStorage.removeItem(key);
        }
    };

    return {
        value: value,
        save: () => save(),
    };
};

export default useLocalStorage;