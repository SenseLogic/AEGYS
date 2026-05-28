<script>
    // -- IMPORTS

    import { onMount } from "svelte";
    import { getApplicationData, getLanguageCodePath, getLocalizedText } from "../application.ts";

    // -- VARIABLES

    export let languageCode;

    let applicationData = getApplicationData();
    let homePageData = applicationData.homePage;
    let path = "/";

    // -- STATEMENTS
    
    onMount(
        () =>
        {
            path = window?.location?.pathname ?? "/";
        }
        );

    // -- FUNCTIONS

    function handleLanguageChange( event )
    {
        window.location.href
            = getLanguageCodePath(
                path,
                event.target.value
                );
    }
</script>

<header class="header-menu">
    <div class="header-menu-container">
        <div class="header-menu-logo">
            <h1 class="header-menu-logo-text">
                { getLocalizedText( homePageData.title ) }
            </h1>
        </div>

        <nav class="header-menu-nav">
            <ul class="header-menu-list">
                {#each applicationData.headerMenuButtonArray as menuButtonItem, buttonIndex}
                    <li class="header-menu-item">
                        <a
                            href={ `/${ languageCode }/${ menuButtonItem.route }` }
                            class="header-menu-button"
                        >
                            <span class="header-menu-button-text">
                                { getLocalizedText( menuButtonItem.text ) }
                            </span>
                        </a>
                    </li>
                {/each}
            </ul>
        </nav>

        <div class="header-menu-language">
            <select
                class="header-menu-language-select"
                value={ languageCode }
                on:change={ handleLanguageChange }
            >
                {#each Object.entries( applicationData.languageByCodeMap ) as [ code, languageItem ]}
                    <option value={ code }>
                        { getLocalizedText( languageItem.name ) }
                    </option>
                {/each}
            </select>
        </div>
    </div>
</header>
