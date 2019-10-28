---
layout: post
title:  "Resolve unchecked warning in pac4j"
date:   2019-2-8 11:35:00 +0800
categories: code
---

In generic object calling, we need pass certain type(s) when we call some function or new some object. A generic object (from pac4j) maybe declares like below:

```java
package org.pac4j.core.authorization.generator;

import org.pac4j.core.context.WebContext;
import org.pac4j.core.profile.CommonProfile;

import java.util.Arrays;
import java.util.Collection;

/**
 * Grant default roles and/or permissions to a user profile.
 *
 * @author Jerome Leleu
 * @since 1.8.0
 */
public class DefaultRolesPermissionsAuthorizationGenerator<U extends CommonProfile> implements AuthorizationGenerator<U> {

    private final Collection<String> defaultRoles;

    private final Collection<String> defaultPermissions;

    public DefaultRolesPermissionsAuthorizationGenerator(final Collection<String> defaultRoles, final Collection<String> defaultPermissions) {
        this.defaultRoles = defaultRoles;
        this.defaultPermissions = defaultPermissions;
    }

    public DefaultRolesPermissionsAuthorizationGenerator(final String[] defaultRoles, final String[] defaultPermissions) {
        if (defaultRoles != null) {
            this.defaultRoles = Arrays.asList(defaultRoles);
        } else {
            this.defaultRoles = null;
        }
        if (defaultPermissions != null) {
            this.defaultPermissions = Arrays.asList(defaultPermissions);
        } else {
            this.defaultPermissions = null;
        }
    }

    @Override
    public U generate(final WebContext context, final U profile) {
        if (defaultRoles != null) {
            profile.addRoles(defaultRoles);
        }
        if (defaultPermissions != null) {
            profile.addPermissions(defaultPermissions);
        }
        return profile;
    }
}
```

In this declaration, we find that the type parameter `U` is never used in this class.
But we need to pass a certain type when we create a `DefaultRolesPermissionsAuthorizationGenerator` object too, otherwise we will get a `unchecked` warning when complie files. We should do it like below:

```java
final Clients clients = new Clients(headerClient);
clients.addAuthorizationGenerator(new DefaultRolesPermissionsAuthorizationGenerator<>(
        Sets.newHashSet("common"),
        Sets.newHashSet("post./auth/v1/changepassword", "get./auth/v1/silentlogin/permissions")
));
```

Notice that we pass empty in `<>`, it means that the compiler can determine, or infer.

## References

- [What does <> mean for java generics?](https://stackoverflow.com/questions/8660202/what-does-mean-for-java-generics)
- [What is unchecked cast and how do I check it?](https://stackoverflow.com/questions/2693180/what-is-unchecked-cast-and-how-do-i-check-it)
- [Pass Compiler Arguments in Maven](http://maven.apache.org/plugins/maven-compiler-plugin/examples/pass-compiler-arguments.html)
