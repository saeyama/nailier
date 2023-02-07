<template>
  <ul class="mb-4">
    <li>
      <a
        href="https://www.nailtat.com/"
        class="external-link bg-no-repeat bg-right pl-2 pr-6 underline hover:text-gray-400"
        target="_blank"
        rel="noopener">
        TATから探す
      </a>
    </li>
    <li>
      <a
        href="https://www.nail-partner.com/"
        class="external-link bg-no-repeat bg-right pl-2 pr-6 underline hover:text-gray-400"
        target="_blank"
        rel="noopener">
        ネイルパートナーから探す
      </a>
    </li>
  </ul>
</template>

<script>
export default {
  name: 'ExternalLink'
}
</script>

<style scoped>
.external-link {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25' /%3E%3C/svg%3E%0A");
}
</style>
