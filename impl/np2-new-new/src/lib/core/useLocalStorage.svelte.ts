import { onMount } from 'svelte';
import { Serializer } from './Serializer';
import { get, writable } from 'svelte/store';

const useLocalStorage = (
    key: string, 
    initialValue: any,
    opt: {
        serialize?: (obj: any) => string,
        revive?: (obj: any) => any,
    } = {
        serialize: (obj: any) => Serializer.serialize(obj),
        revive: (obj: any) => Serializer.revive(obj),
    }
) => {
    let value = writable(initialValue);

    onMount(() => {
        console.log('useLocalStorage::onMount')
        const currentValue = localStorage.getItem(key);
        if (currentValue) 
            value = JSON.parse(currentValue);
    });

    const save = () => {
        console.log('useLocalStorage::save')
        if (value) {
            localStorage.setItem(key, JSON.stringify(value));
        } else {
            localStorage.removeItem(key);
        }
    };

    let obj = {
        value,
        save,
    };
    return obj;
};

export default useLocalStorage;