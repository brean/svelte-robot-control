<script lang="ts">
	import { onMount } from "svelte";
import {
  GamepadManager, KeyboardManager, Joystick
} from "svelte-gamepad-virtual-joystick";

let position: [x: number, y: number] = $state([0, 0]);

// connect to get WebRTC video stream directly
// peer connection

const config: RTCConfiguration = {};
let pc: RTCPeerConnection | undefined;
let videoElem: HTMLVideoElement;

// data channel
let dc = null, dcInterval = null;

function createPeerConnection() {
  pc = new RTCPeerConnection(config);
  
  // we only want to receive video data
  pc.addTransceiver('video', { direction: 'recvonly' });

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
      videoElem.srcObject = evt.streams[0];
    }
  });
}

onMount(() => {
  createPeerConnection();
});

// TODO: websocket-server to forward Joystick values
</script>

<video
  style="width: 1280px; height: 720px; border: 1px solid red; position: absolute; top: 0; left: 0;"
  id="video"
  bind:this={videoElem}
  autoplay
  muted={true}
  playsinline
  controls={false}>
  <track kind="captions" />
</video>

<Joystick
  style="background-color: rgb(6, 23, 28); position: absolute; top: 0; left: 0; z-index: 1"
  size={120}
  bind:position={position}
/>

<!-- GamepadManager and KeyboardManager should be unique in your page. -->
<GamepadManager />
<KeyboardManager />

