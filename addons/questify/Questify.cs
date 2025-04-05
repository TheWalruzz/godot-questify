using Godot;
using Microsoft.VisualBasic;
using System;
using System.Numerics;

public class Questify 
{

   #region Initialize
   private static readonly NodePath nodePath = new("/root/Questify");
   private Node QuestifyNode;

   /*
     You can Initialize like this example :
 
    Questify questify;
    [Export] Resource Quest;
   public override void _Ready()
   {

   questify = new Questify(this);

  // Then you can use it easily :

   var QuestInstantiated = questify.Instantiate(Quest);
       questify.StartQuest(QuestInstantiated);

   }
     // That's It !
      */


   public Questify(Node InitializeFrom)
   {
      QuestifyNode = InitializeFrom.GetTree().Root.GetNode(nodePath);
   }
   #endregion


   #region Functions


   public Resource Instantiate(Resource QuestResource)
   {
      SceneTree tree = new SceneTree();
      return ((Resource)QuestResource.Call(FuncName.Instantiate));
   }

   public void StartQuest(Resource Quest)
   {
      QuestifyNode.Call(FuncName.StartQuest, Quest );
   }

   public void SetConditionCompleted(Resource QuestCondition , bool Complete)
   {
      QuestCondition.Call(FuncName.SetConditionCompleted, Complete );
   }

   public void ToggleUpdatePolling(bool UpdatePolling)
   {
      QuestifyNode.Call(FuncName.ToggleUpdatePolling, UpdatePolling);
   }

   public void UpdateQuests()
   {
      QuestifyNode.Call(FuncName.UpdateQuests);
   }

   public Godot.Collections.Array<Resource> GetQuests()
   {
     return ((Godot.Collections.Array<Resource>)QuestifyNode.Call(FuncName.GetQuests));
   }

   public Godot.Collections.Array<Resource> GetActiveQuests()
   {
      return QuestifyNode.Call(FuncName.GetActiveQuests).As<Godot.Collections.Array<Resource>>();
   }

   public Godot.Collections.Array<Resource> GetCompletedQuests()
   {
      return QuestifyNode.Call(FuncName.GetCompletedQuests).As<Godot.Collections.Array<Resource>>();
   }

   public void SetQuests(Godot.Collections.Array<Resource> Quests)
   {
      QuestifyNode.Call(FuncName.SetQuests,Quests);
   }
   
   public Godot.Collections.Array Serialize()
   {
     return QuestifyNode.Call(FuncName.Serialize).As<Godot.Collections.Array>();
   }

   public void Deserialize(Godot.Collections.Array Data)
   {
      QuestifyNode.Call(FuncName.Deserialize,Data);
   }

   public string GetResourcePath(Resource Quest)
   {
      return ((Resource)Quest).Call(FuncName.GetResourcePath).As<string>();
   }

   public void Clear()
   {
      QuestifyNode.Call(FuncName.Clear);
   }

   #endregion



   #region Signals Handler
   public void ConnectQuestStarted(Action<Resource> method)
   {
      QuestifyNode.Connect(SignalName.QuestStarted, Callable.From(method));
   }
   /// <summary>
   /// Connect method to "ConditionQueryRequested" , And parameters method is :
   /// method ( string QueryType , string Key , Variant Value , Resource Requester )
   /// </summary>
   public void ConnectConditionQueryRequested(Action<string,string,Variant, Resource> method)
   {
    
      QuestifyNode.Connect(SignalName.ConditionQueryRequested, Callable.From(method));
   }
   /// <summary>
   /// Connect method to "QuestObjectiveAdded" And parameters method is :
   /// method ( Resource Quest , Resource Objective )
   /// </summary>
   public void ConnectQuestObjectiveAdded(Action<Resource, Resource> method)
   {
      QuestifyNode.Connect(SignalName.QuestObjectiveAdded, Callable.From(method));
   }

   /// <summary>
   /// Connect method to "QuestObjectiveCompleted" And parameters method is :
   /// method ( Resource Quest , Resource Objective )
   /// </summary>
   /// <param name="method"></param>
   public void ConnectQuestObjectiveCompleted(Action<Resource, Resource> method)
   {
      QuestifyNode.Connect(SignalName.QuestObjectiveCompleted, Callable.From(method));
   }

   /// <summary>
   /// Connect method to "QuestCompleted" And parameters method is :
   /// method ( Resource Quest )
   /// </summary>
   /// <param name="method"></param>
   public void ConnectQuestCompleted(Action<Resource> method)
   {
      QuestifyNode.Connect(SignalName.QuestCompleted, Callable.From(method));
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
