#  README

https://app.json-generator.com

```
JG.repeat(1000, {
  identifier: JG.objectId(),
  name: JG.company(),
  staff: JG.repeat(5, {
    identifier: JG.objectId(),
    name: `${JG.firstName()} ${JG.lastName()}`
  }),
});
```
