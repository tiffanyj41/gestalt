/* 
   ------------------------------------------------------------------------- 
   gestalt_workspace_panel
   This table lists the relationship between a workspace and a panel. 
   * workspace_id: workspace id in gestalt_workshop_table
   * panel_id: panel id in gestalt_panel_table
   * is_default: label the panel as the default
   *     When you go to a workspace, you want to show the default panel
   *     first. 
   -------------------------------------------------------------------------
 */

DROP TABLE IF EXISTS gestalt_workspace_panel CASCADE;

CREATE TABLE gestalt_workspace_panel (
    id SERIAL PRIMARY KEY,
    workspace_id INTEGER REFERENCES gestalt_workspace(id),
    panel_id INTEGER REFERENCES gestalt_panel(id),
    is_default BOOLEAN DEFAULT FALSE,
    UNIQUE (workspace_id, panel_id)
);

CREATE UNIQUE INDEX only_one_default_panel_check
  ON gestalt_workspace_panel(workspace_id)
  WHERE is_default = TRUE;

INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (1, 1, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (2, 1, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (3, 1, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (4, 1, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (1, 2, FALSE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (2, 2, FALSE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (3, 2, FALSE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (4, 2, FALSE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (5, 3, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (6, 3, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (7, 3, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (8, 3, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (9, 4, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (10, 4, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (11, 4, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (12, 4, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (13, 5, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (14, 5, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (15, 5, TRUE);
INSERT INTO gestalt_workspace_panel(workspace_id, panel_id, is_default) VALUES
    (16, 5, TRUE);

/* 
   ------------------------------------------------------------------------- 
   gestalt_wp_story
   This table lists the relationship between a panel and a story depending
   on what the workspace is.
   * wp_id: workspace-panel id in gestalt_workspace_panel table
   * story_id: story id in gestalt_story table
   * is_default: label the story as the default
   *     When you go to a panel, you want to show the default story first.
   -------------------------------------------------------------------------
 */

DROP TABLE IF EXISTS gestalt_wp_story;

CREATE TABLE gestalt_wp_story ( 
    id SERIAL PRIMARY KEY,
    wp_id INTEGER REFERENCES gestalt_workspace_panel(id),
    story_id INTEGER REFERENCES gestalt_story(id),
    is_default BOOLEAN DEFAULT FALSE,
    UNIQUE (wp_id, story_id)
);

CREATE UNIQUE INDEX only_one_default_story_check
  ON gestalt_wp_story(wp_id)
  WHERE is_default = TRUE;
 
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (1, 2, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (2, 2, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (3, 2, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (4, 2, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (5, 1, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (6, 1, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (7, 1, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (8, 1, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (9, 3, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (10, 3, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (11, 3, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (12, 3, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (13, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (14, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (15, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (16, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (17, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (18, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (19, 4, TRUE);
INSERT INTO gestalt_wp_story (wp_id, story_id, is_default) VALUES
    (20, 4, TRUE);

/* 
   ------------------------------------------------------------------------- 
   gestalt_vis_url
   This table lists the url named by the vis. The url is also used as the
   template to display the vis. Each template can be reused by multiple vis.
   * id: url id
   * name: url name
   -------------------------------------------------------------------------
 */

DROP TABLE IF EXISTS gestalt_vis_url CASCADE;

CREATE TABLE gestalt_vis_url (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL CHECK (name <> ''),
    UNIQUE (name)
);

INSERT INTO gestalt_vis_url (name) VALUES ('group-nodes');
INSERT INTO gestalt_vis_url (name) VALUES ('tbd');
INSERT INTO gestalt_vis_url (name) VALUES ('visual-standard');
/* 
   ------------------------------------------------------------------------- 
   gestalt_story_vis
   This table lists the relationship between a story and its respective
   visualization(s). The default visualization for a story will be the one
   that has an order number 1. There can be multiple visualizations 
   representing a story, and they can go in sequence to tell that story.
   * story_id: story id in gestalt_story table
   * vis_id: vis id in gestalt_vis table
   * url_vis: the url used to refer to this vis
   *          the url is also used as the template to display the vis
   *          url id in gestalt_vis_url
   * order_num: label the vis with an order number that it will appear
   -------------------------------------------------------------------------
 */

DROP TABLE IF EXISTS gestalt_story_vis;

CREATE TABLE gestalt_story_vis ( 
    id SERIAL PRIMARY KEY,
    story_id INTEGER REFERENCES gestalt_story(id),
    vis_id INTEGER REFERENCES gestalt_vis(id),
    url_id INTEGER REFERENCES gestalt_vis_url(id),
    order_num INTEGER DEFAULT 1,
    UNIQUE (story_id, vis_id, order_num)
);

INSERT INTO gestalt_story_vis (story_id, vis_id, url_id) VALUES
    (1, 3, 2);
INSERT INTO gestalt_story_vis (story_id, vis_id, url_id) VALUES
    (2, 3, 2);
INSERT INTO gestalt_story_vis (story_id, vis_id, url_id) VALUES
    (3, 2, 1);
INSERT INTO gestalt_story_vis (story_id, vis_id, url_id) VALUES
    (4, 3, 2);
