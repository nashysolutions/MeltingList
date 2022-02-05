#  README

https://app.json-generator.com

```
JG.repeat(3, {
  identifier: JG.guid(),
  name: JG.company(),
  staff: JG.repeat(5, {
    identifier: JG.guid(),
    name: `${JG.firstName()} ${JG.lastName()}`
  }),
});
```
