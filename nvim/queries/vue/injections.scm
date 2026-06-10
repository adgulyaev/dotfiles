; ~/.config/nvim/queries/vue/injections.scm
; extends

; Inject HTML into <template> blocks (no lang attribute)
((template_element
   (start_tag) @_start
   (#not-has-attribute? @_start "lang")
   (raw_text) @injection.content)
 (#set! injection.language "html"))

; <template lang="html"> explicit
((template_element
   (start_tag
     (attribute
       (attribute_name) @_attr
       (quoted_attribute_value
         (attribute_value) @_lang)
       (#eq? @_attr "lang")
       (#eq? @_lang "html")))
   (raw_text) @injection.content)
 (#set! injection.language "html"))

; Inject TypeScript into <script lang="ts">
((script_element
   (start_tag
     (attribute
       (attribute_name) @_attr
       (quoted_attribute_value
         (attribute_value) @_lang)
       (#eq? @_attr "lang")
       (#eq? @_lang "ts")))
   (raw_text) @injection.content)
 (#set! injection.language "typescript"))

; Inject JavaScript into plain <script>
((script_element
   (start_tag) @_start
   (#not-has-attribute? @_start "lang")
   (raw_text) @injection.content)
 (#set! injection.language "javascript"))

; Inject CSS into <style> (no lang)
((style_element
   (start_tag) @_start
   (#not-has-attribute? @_start "lang")
   (raw_text) @injection.content)
 (#set! injection.language "css"))

; Inject SCSS into <style lang="scss">
((style_element
   (start_tag
     (attribute
       (attribute_name) @_attr
       (quoted_attribute_value
         (attribute_value) @_lang)
       (#eq? @_attr "lang")
       (#eq? @_lang "scss")))
   (raw_text) @injection.content)
 (#set! injection.language "scss"))
