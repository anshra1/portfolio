# Homepage Component Structure Plan

## 1. SiteHeader Section
*Responsibility: Navigation, Branding, and Responsive Menu*
- `SiteHeader` (Main Container)
    - `BrandLogo`
    - `DesktopNavigation`
        - `NavItem` (Repeated)
    - `MobileMenuToggle`
    - `MobileMenuOverlay`
        - `MobileNavItem` (Repeated)

## 2. HeroSection
*Responsibility: Initial hook, CTA, and social presence*
- `HeroSection` (Main Container)
    - `HeroTitle`
    - `HeroSubtitle`
    - `HeroActionGroup`
        - `PrimaryCTA`
        - `SecondaryCTA`
    - `SocialLinks`
        - `SocialIcon` (Repeated)

## 3. ProjectsSection
*Responsibility: Showcasing portfolio items*
- `ProjectsSection` (Main Container)
    - `SectionHeader` (Title + Subtitle)
    - `ProjectGrid`
    - `ProjectCard`
        - `ProjectThumbnail`
        - `ProjectCardHeader`
        - `ProjectTechStack`
        - `ProjectActionButtons`
    - `ViewMoreButton`

## 4. LearningsSection
*Responsibility: Educational content and blog snippets*
- `LearningsSection` (Main Container)
    - `SectionHeader`
    - `InsightsGrid`
    - `InsightCard`
        - `InsightThumbnail`
        - `InsightMetadata` (Date, Read Time)
        - `InsightTitle`
        - `InsightExcerpt`
        - `TopicTags`
    - `ViewAllButton`

## 5. AboutSection
*Responsibility: Personal introduction and biography*
- `AboutSection` (Main Container)
    - `BioContent` (Rich Text/Markdown)
    - `ProfileAvatar` (Styled image)

## 6. ExpertiseSection
*Responsibility: Technical skills and proficiency*
- `ExpertiseSection` (Main Container)
    - `SectionHeader`
    - `SkillsGrid`
    - `SkillCard`
        - `SkillIcon`
        - `SkillTitle`
        - `SkillDescription`

## 7. SiteFooter Section
*Responsibility: Final CTA and copyright*
- `SiteFooter` (Main Container)
    - `FooterCTA`
    - `ContactButton`
    - `FooterSocialLinks`
    - `CopyrightNotice`

## 8. Global Overlay Components
- `ContactFAB` (Floating Action Button)
- `ArticleReaderDrawer` (Bottom Sheet / Overlay for reading articles)
