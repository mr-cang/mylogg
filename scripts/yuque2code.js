hexo.extend.filter.register('before_post_render', function (data) {
  if (!data.content) return data;

  let prev;
  do {
    prev = data.content;

    data.content = data.content.replace(
      /<font[^>]*>([\s\S]*?)<\/font>/g,
      function (_, inner) {
        let text = inner.replace(/<[^>]+>/g, '').trim();

        if (!text) return '';

        // ❗ 如果已经是代码，不再处理
        if (/^`.*`$/.test(text)) return text;

        // 👉 多行才允许变代码块
        const isMultiLine = text.includes('\n');

        // 👉 更严格：必须像“真正代码”
        const isCodeLike = /(;|\{|\}|=)/.test(text);

        if (isMultiLine && isCodeLike) {
          return '\n```java\n' + text + '\n```\n';
        }

        // 👉 单行：只处理“纯代码”
        if (!isMultiLine && /^[a-zA-Z0-9_.]+\(\)$/.test(text)) {
          return '`' + text + '`';
        }

        return text;
      }
    );

  } while (data.content !== prev);

  return data;
});