<template>
  <div>
    <div class="text-lg">卸サイト</div>
    <ul class="grid gap-1 ml-2 mt-2">
      <li>
        <a
          href="https://www.nailtat.com/"
          class="external-link"
          target="_blank"
          rel="noopener">
          <span class="pr-1">TAT</span>
          <ArrowTopRightOnSquareIcon class="w-5 h-5 stroke-1" />
        </a>
      </li>
      <li>
        <a
          href="https://www.nail-partner.com/"
          class="external-link"
          target="_blank"
          rel="noopener">
          <span class="pr-1">ネイルパートナー</span>
          <ArrowTopRightOnSquareIcon class="w-5 h-5 stroke-1" />
        </a>
      </li>
      <li>
        <a
          href="https://www.naillabo.jp/"
          class="external-link"
          target="_blank"
          rel="noopener">
          <span class="pr-1">Nail Labo</span>
          <ArrowTopRightOnSquareIcon class="w-5 h-5 stroke-1" />
        </a>
      </li>
    </ul>
  </div>
</template>

<script>
import { ArrowTopRightOnSquareIcon } from '@heroicons/vue/24/outline'
export default {
  components: {
    ArrowTopRightOnSquareIcon
  },
  name: 'ExternalLinks'
}
</script>
