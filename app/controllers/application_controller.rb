class ApplicationController < ActionController::Base
    def placeholder_set
        @placeholder = {}
        @placeholder["Number"]   = "例）1~10/50~100"
        @placeholder["Text"]     = "例）武器/\"防具\""
        @placeholder["Name"]     = "例）太郎/\"次郎\""
        @placeholder["Skill"]    = "例）スラッシュ/\"ラッシュ\""
        @placeholder["Item"]     = "例）不思議な食材"
        @placeholder["ItemKind"] = "例）武器/素材/食材"
        @placeholder["Fuka"]     = "例）活力/\"鎮痛\""
    end
end
