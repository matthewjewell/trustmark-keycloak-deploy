<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form" class="container" style="max-width: 540px;">
            <div id="kc-form-wrapper" class="border rounded card">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                        <div class="card-body pb-2">
                            <#if !usernameHidden??>
                                <div class="${properties.kcFormGroupClass!} row pb-2">
                                    <label for="username"
                                           class="${properties.kcLabelClass!} col-4 col-form-label text-end"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                                    <div class="col-8">
                                        <input tabindex="1" id="username"
                                               class="${properties.kcInputClass!} <#if messagesPerField.existsError('username','password')>is-invalid</#if> form-control"
                                               name="username" value="${(login.username!'')}" type="text" autofocus
                                               autocomplete="off"
                                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                               aria-describedby="input-error-username"
                                        />

                                        <#if messagesPerField.existsError('username','password')>
                                            <div id="input-error-username"
                                                 class="${properties.kcInputErrorMessageClass!} invalid-feedback"
                                                 aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </div>
                                        </#if>
                                    </div>


                                </div>
                            </#if>

                            <div class="${properties.kcFormGroupClass!} row pb-2">
                                <label for="password"
                                       class="${properties.kcLabelClass!} col-4 col-form-label text-end">${msg("password")}</label>

                                <div class="col-8">
                                    <input tabindex="2" id="password"
                                           class="${properties.kcInputClass!} <#if usernameHidden?? && messagesPerField.existsError('username','password')>is-invalid</#if> form-control"
                                           name="password" type="password" autocomplete="off"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                           aria-describedby="input-error-password"
                                    />

                                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                        <div id="input-error-password"
                                             class="${properties.kcInputErrorMessageClass!} invalid-feedback"
                                             aria-live="polite">
                                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                        </div>
                                    </#if>
                                </div>


                            </div>

                            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                                <div id="kc-form-options">
                                    <#if realm.rememberMe && !usernameHidden??>
                                        <div class="checkbox">
                                            <label>
                                                <#if login.rememberMe??>
                                                    <input tabindex="3" id="rememberMe" name="rememberMe"
                                                           type="checkbox" checked> ${msg("rememberMe")}
                                                <#else>
                                                    <input tabindex="3" id="rememberMe" name="rememberMe"
                                                           type="checkbox"> ${msg("rememberMe")}
                                                </#if>
                                            </label>
                                        </div>
                                    </#if>
                                </div>
                                <div class="${properties.kcFormOptionsWrapperClass!}">
                                    <#if realm.resetPasswordAllowed>
                                        <span><a tabindex="5"
                                                 href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                    </#if>
                                </div>

                            </div>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} card-footer">
                            <input type="hidden" id="id-hidden-input" name="credentialId"
                                   <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                            <div class="row">
                                <div class="col-4"></div>

                                <div class="col-8 text-start">
                                    <input tabindex="4"
                                           class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn-primary"
                                           name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>

                                </div>
                            </div>
                        </div>
                    </form>
                </#if>
            </div>

        </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!} container pt-4" style="max-width: 540px">
                <h2>${msg("identity-provider-login-label")}</h2>

                <div class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if> border rounded card">
                    <div class="card-body pb-2">
                    <#list social.providers as p>
                        <a id="social-${p.alias}"
                           class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if> btn btn-primary  w-100 mb-2"
                           type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                    </div>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
