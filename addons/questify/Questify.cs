using Godot;
using System;

public static class Questify 
{

   #region Initialize
   private static readonly NodePath nodePath = new("/root/Questify");
   private static Node instance;
   private static void instanceNode()
   { 
      if (instance == null)
      {
         instance = ((SceneTree)Engine.GetMainLoop()).Root.GetNode(nodePath);
      }
   }
   #endregion


   #region Functions

   public static Resource Instantiate(Resource questResource)
   {
      instanceNode();
      return ((Resource)questResource.Call(FuncName.Instantiate));
   }

   public static void StartQuest(Resource quest)
   {
      instanceNode();
      instance.Call(FuncName.StartQuest, quest );
   }

   public static void SetConditionCompleted(Resource questCondition , bool complete)
   {
      instanceNode();
      questCondition.Call(FuncName.SetConditionCompleted, complete );
   }

   public static void ToggleUpdatePolling(bool updatePolling)
   {
      instanceNode();
      instance.Call(FuncName.ToggleUpdatePolling, updatePolling);
   }

   public static void UpdateQuests()
   {
      instanceNode();
      instance.Call(FuncName.UpdateQuests);
   }

   public static Godot.Collections.Array<Resource> GetQuests()
   {
      instanceNode();
      return ((Godot.Collections.Array<Resource>)instance.Call(FuncName.GetQuests));
   }

   public static Godot.Collections.Array<Resource> GetActiveQuests()
   {
      instanceNode();
      return instance.Call(FuncName.GetActiveQuests).As<Godot.Collections.Array<Resource>>();
   }

   public static Godot.Collections.Array<Resource> GetCompletedQuests()
   {
      instanceNode();
      return instance.Call(FuncName.GetCompletedQuests).As<Godot.Collections.Array<Resource>>();
   }

   public static void SetQuests(Godot.Collections.Array<Resource> quests)
   {
      instanceNode();
      instance.Call(FuncName.SetQuests,quests);
   }
   
   public static Godot.Collections.Array Serialize()
   {
      instanceNode();
      return instance.Call(FuncName.Serialize).As<Godot.Collections.Array>();
   }

   public static void Deserialize(Godot.Collections.Array data)
   {
      instanceNode();
      instance.Call(FuncName.Deserialize,data);
   }

   public static string GetResourcePath(Resource quest)
   {
      instanceNode();
      return ((Resource)quest).Call(FuncName.GetResourcePath).As<string>();
   }

   public static void Clear()
   {
      instanceNode();
      instance.Call(FuncName.Clear);
   }

   #endregion



   #region Signals Handlers
   public static void ConnectQuestStarted(Action<Resource> method)
   {
      instanceNode();
      instance.Connect(SignalName.QuestStarted, Callable.From(method));
   }
   /// <summary>
   /// Connect method to "ConditionQueryRequested" , And parameters method is :
   /// method ( string QueryType , string Key , Variant Value , Resource Requester )
   /// </summary>
   public static void ConnectConditionQueryRequested(Action<string,string,Variant, Resource> method)
   {
      instanceNode();
      instance.Connect(SignalName.ConditionQueryRequested, Callable.From(method));
   }
   /// <summary>
   /// Connect method to "QuestObjectiveAdded" And parameters method is :
   /// method ( Resource Quest , Resource Objective )
   /// </summary>
   public static void ConnectQuestObjectiveAdded(Action<Resource, Resource> method)
   {
      instanceNode();
      instance.Connect(SignalName.QuestObjectiveAdded, Callable.From(method));
   }

   /// <summary>
   /// Connect method to "QuestObjectiveCompleted" And parameters method is :
   /// method ( Resource Quest , Resource Objective )
   /// </summary>
   /// <param name="method"></param>
   public static void ConnectQuestObjectiveCompleted(Action<Resource, Resource> method)
   {
      instanceNode();
      instance.Connect(SignalName.QuestObjectiveCompleted, Callable.From(method));
   }

   /// <summary>
   /// Connect method to "QuestCompleted" And parameters method is :
   /// method ( Resource Quest )
   /// </summary>
   /// <param name="method"></param>
   public static void ConnectQuestCompleted(Action<Resource> method)
   {
      instanceNode();
      instance.Connect(SignalName.QuestCompleted, Callable.From(method));
   }

   #endregion



   #region References Names
   private static class FuncName
   {
      
      public static readonly StringName StartQuest = "start_quest";
      public static readonly StringName Instantiate = "instantiate";
      public static readonly StringName SetConditionCompleted = "set_completed";
      public static readonly StringName ToggleUpdatePolling = "toggle_update_polling";
      public static readonly StringName UpdateQuests = "update_quests";
      public static readonly StringName GetQuests = "get_quests";
      public static readonly StringName GetActiveQuests = "get_active_quests";
      public static readonly StringName GetCompletedQuests = "get_completed_quests";
      public static readonly StringName SetQuests = "set_quests";
      public static readonly StringName Serialize = "serialize";
      public static readonly StringName Deserialize = "deserialize";
      public static readonly StringName GetResourcePath = "get_resource_path";
      public static readonly StringName Clear = "clear";
   }

   private static class SignalName
   {
      public static readonly StringName QuestStarted = "quest_started";
      public static readonly StringName ConditionQueryRequested = "condition_query_requested";
      public static readonly StringName QuestObjectiveAdded = "quest_objective_added";
      public static readonly StringName QuestObjectiveCompleted = "quest_objective_completed";
      public static readonly StringName QuestCompleted = "quest_completed";
   }
   #endregion

}
