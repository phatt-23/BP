<!--
Created by phatt-23 on 12/10/2025
-->

<script lang="ts">
	class Counter {
		public count: number = $state(0);
        public increment() {
            this.count++;
        }
	}

	let counter = $state({ "neco": new Counter() });

	function handleClick() {
		counter.neco.count++; 
		console.log(counter.neco.count); 
	}
</script>

<button onclick={handleClick}>
	Count is {counter.neco.count}
</button>

<button onclick={() => { 
    counter.neco.increment();
	console.log(counter.neco.count); 
}}>
	Count is {counter.neco.count}
</button>