<script lang="ts">
	import { onMount } from "svelte";
import {
  GamepadManager, KeyboardManager, Joystick
} from "svelte-gamepad-virtual-joystick";

let position: [x: number, y: number] = $state([0, 0]);

// connect to get WebRTC video stream directly
// peer connection

onMount(() => {
  // TODO: get media - see https://github.com/Yakumwamba/google_webrtc_svelte/blob/master/src/routes/camera_res/index.svelte
  const config: RTCConfiguration = {};
  let pc: RTCPeerConnection | undefined

  // data channel
  let dc = null, dcInterval = null;

  function createPeerConnection() {
    pc = new RTCPeerConnection(config);
    // register some listeners to help debugging
    pc.addEventListener('icegatheringstatechange', () => {
        console.log(pc?.iceGatheringState);
    }, false);

    pc.addEventListener('iceconnectionstatechange', () => {
        console.log(pc?.iceConnectionState);
    }, false);

    pc.addEventListener('signalingstatechange', () => {
      console.log(pc?.signalingState);
    }, false);

    // connect audio / video
    pc.addEventListener('track', (evt) => {
      if (evt.track.kind == 'video') {
        document.getElementById('video').srcObject = evt.streams[0];
      }
    });
  }

  function start() {
    createPeerConnection();
  }

  start();
});

// TODO: websocket-server to forward Joystick values
</script>

<Joystick
  style="background-color: rgb(6, 23, 28);"
  size={120}
  bind:position={position}
/>

<video style="width: 1280px; height: 720px" id="video" />

<!-- GamepadManager and KeyboardManager should be unique in your page. -->
<GamepadManager />
<KeyboardManager />

