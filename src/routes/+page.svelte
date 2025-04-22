<script lang="ts">
import {
  GamepadManager, KeyboardManager, Joystick
} from "svelte-gamepad-virtual-joystick";

let position: [x: number, y: number] = $state([0, 0]);

// connect to get WebRTC video stream directly
// we might get this from a websocket-server in the future that also accepts the 
// virtual joystick values
</script>

<Joystick
  style="background-color: rgb(6, 23, 28);"
  size={120}
  bind:position={position}
/>

<!-- GamepadManager and KeyboardManager should be unique in your page. -->
<GamepadManager />
<KeyboardManager />

